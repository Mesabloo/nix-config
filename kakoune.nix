{ config, options, lib, pkgs, unstable, ... }:

let
  kakship = pkgs.rustPlatform.buildRustPackage rec {
    pname = "kakship";
    version = "0.2.8";
    src = pkgs.fetchFromGitHub {
      owner = "mesabloo";
      repo = "kakship";
      rev = "937d904a893daf59f70dc955e60209cd8866a7c3";
      sha256 = "1pk0v0b31bppjzl08qgrjld40pc7rqc257zzgdl4r8zaamqsmkz9";
    };
    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "kak-0.1.2" = "sha256-RhtHQkC9yCSJtr/kbC5c9MavbL79acrsiEGXyoAST8U=";
        "yew-ansi-0.1.0" = "sha256-dSaEzqiOon+OqCZKQudzLRNP+Iv97kC+XZcTElKNrzs=";
      };
    };

    buildInputs = with pkgs; [
      starship
    ];

    patchPhase = ''
      substituteInPlace src/main.rs \
        --replace '"starship"' "\"${pkgs.starship}/bin/starship\""
    '';

    postInstall = ''
      # Copy rc files to /share/kak/autoload
      mkdir -p $out/share/kak/autoload/plugins/${pname}
      cp $src/rc/*.kak $out/share/kak/autoload/plugins/${pname}
    '';
  };

  kak-lsp' = pkgs.kak-lsp.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      mkdir -p $out/share/kak/autoload/plugins/${old.pname}
      mkdir -p $out/lib
      cp $src/rc/lsp.kak $out/lib/lsp.kak
      cat >$out/share/kak/autoload/plugins/${old.pname}/lsp.kak <<EOF
        provide-module lsp %{
          source $out/lib/lsp.kak
        }
      EOF
    '';
  });

  kak-rainbow = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "kak-rainbow";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "Bodhizafa";
      repo = "kak-rainbow";
      rev = "9c3d0aa62514134ee5cb86e80855d9712c4e8c4b";
      sha256 = "sha256-ryYq4A89wVUsxgvt4YqBPXsTFMDrMJM6BDBEHrWHD1c=";
    };

    postInstall = ''
      mkdir -p $out/lib
      mv $out/share/kak/autoload/plugins/${pname}/rainbow.kak $out/lib
      cat >$out/share/kak/autoload/plugins/${pname}/rainbow.kak <<EOF
        provide-module rainbow %{
          source $out/lib/rainbow.kak
        }
      EOF
    '';
  };

  kakrc = pkgs.writeTextFile rec {
    name = "kakrc.kak";
    destination = "/share/kak/autoload/${name}";
    text = builtins.readFile ./config/kakrc;
  };

  my-kakoune = unstable.kakoune.override {
    plugins = with pkgs.kakounePlugins; [
      smarttab-kak
      kak-rainbow
      kakoune-extra-filetypes
      kakoune-buffers
      kakboard
      # kak-ansi
      kakship
      kak-lsp'
      # Necessary transitive dependencies
      connect-kak
      prelude-kak
      # The configuration file
      kakrc
    ];
  };
in
{
  home.packages = with pkgs; [
    kakship
    my-kakoune
    xclip
    xorg.xmessage
    kak-lsp'
    ranger
    # These packages are used by the default autoloading kakrc
    gnused
    findutils
    coreutils
    # Kakoune rainbow needs Guile
    guile
  ];

  xdg.configFile."kak/starship.toml".source = ./config/starship.toml;
  xdg.configFile."kak-lsp/kak-lsp.toml".source = ./config/kak-lsp.toml;
}