{ lib
, stdenv
, fetchzip
, unzip
  # , python3
, config
, acceptLicense ? config.input-fonts.acceptLicense or true # I don't care, I copied all this to change the style of the font
}:

let

  throwLicense = throw ''
    Input is available free of charge for private/unpublished usage. This includes things like your personal coding app or for composing plain text documents.
    To use it, you need to agree to its license: https://input.djr.com/license/
    You can express acceptance by setting acceptLicense to true in your
    configuration. Note that this is not a free license so it requires allowing
    unfree licenses.
    configuration.nix:
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.input-fonts.acceptLicense = true;
    config.nix:
      allowUnfree = true;
      input-fonts.acceptLicense = true;
    If you would like to support this project, consider purchasing a license at <http://input.djr.com/buy>.
  '';

in

stdenv.mkDerivation rec {
  pname = "input-fonts";
  version = "1.2";

  src = ./input-fonts.zip;
  sourceRoot = ".";
#    assert !acceptLicense -> throwLicense;
#    fetchzip {
#      name = "input-fonts-${version}";
#      # Add .zip parameter so that zip unpackCmd can match it.
#      url = "https://input.djr.com/build/?fontSelection=whole&a=0&g=0&i=serif&l=serif&zero=0&asterisk=height&braces=straight&preset=pragmata&line-height=1.1&accept=I+do&email=&.zip";
#      sha256 = "sha256-+LPHO1oTZVLd6GuDiFjvnB9MayWFQ5V20LzqMMFZI+Q=";
#      stripRoot = false;#

      # postFetch = ''
      #   # Reset the timestamp to release date for determinism.
      #   PATH=${lib.makeBinPath [ python3.pkgs.fonttools ]}:$PATH
      #   for ttf_file in $out/Input_Fonts/*/*/*.ttf; do
      #     ttx_file=$(dirname "$ttf_file")/$(basename "$ttf_file" .ttf).ttx
      #     ttx "$ttf_file"
      #     rm "$ttf_file"
      #     touch -m -t ${builtins.replaceStrings [ "-" ] [ "" ] releaseDate}0000 "$ttx_file"
      #     ttx --recalc-timestamp "$ttx_file"
      #     rm "$ttx_file"
      #   done
      # '';
#    };

  buildInputs = [ unzip ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    find Input_Fonts -name "*.ttf" -exec cp -a {} "$out"/share/fonts/truetype/ \;
    mkdir -p "$out"/share/doc
    cp -a *.txt "$out"/share/doc/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Fonts for Code, from Font Bureau";
    longDescription = ''
      Input is a font family designed for computer programming, data,
      and text composition. It was designed by David Jonathan Ross
      between 2012 and 2014 and published by The Font Bureau. It
      contains a wide array of styles so you can fine-tune the
      typography that works best in your editing environment.
      Input Mono is a monospaced typeface, where all characters occupy
      a fixed width. Input Sans and Serif are proportional typefaces
      that are designed with all of the features of a good monospace —
      generous spacing, large punctuation, and easily distinguishable
      characters — but without the limitations of a fixed width.
    '';
    homepage = "https://input.djr.com/";
    license = licenses.unfree;
    maintainers = with maintainers; [
      romildo
    ];
    platforms = platforms.all;
  };
}