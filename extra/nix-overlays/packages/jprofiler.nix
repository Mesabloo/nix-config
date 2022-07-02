{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "jprofiler";
  version = "13.0.2";

  src = pkgs.fetchurl {
    url = "https://download-gcdn.ej-technologies.com/jprofiler/jprofiler_linux_${builtins.replaceStrings ["."] ["_"] version}.deb";
    sha256 = "1cd5s8wxhcq89avjxy151f33nfgaxrdi2p30xwixqxnqyhn2clml";
  };

  unpackCmd = "${pkgs.dpkg}/bin/dpkg-deb -x $curSrc .";

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    jdk
    musl
    xorg.libX11
  ];

  installPhase = ''
    cp -r jprofiler13 $out
  '';
}
