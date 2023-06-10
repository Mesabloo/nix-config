{ stdenv, fetchurl, autoPatchelfHook, unzip, freetype }:

stdenv.mkDerivation rec {
  name = "noise-suppression-for-voice";
  version = "1.03";

  src = fetchurl {
    url = "https://github.com/werman/noise-suppression-for-voice/releases/download/v${version}/linux-rnnoise.zip";
    sha256 = "sha256-LRlFHlRr047TUAfQ5D1DF+cvE5MwT+GIP45yv40vXoU=";
  };

  nativeBuildInputs = [
    unzip
  ];

  buildInputs = [
    freetype
    stdenv.cc.cc.lib
    autoPatchelfHook
  ];

  installPhase = ''
    mkdir -p $out/lib/
    cp -r * $out/lib
  '';
}
