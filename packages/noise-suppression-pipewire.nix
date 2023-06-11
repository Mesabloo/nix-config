{ stdenv, fetchurl, freetype, cmake, fetchFromGitHub, pkg-config, xorg }:
  
stdenv.mkDerivation rec {
  pname = "noise-suppression-for-voice";
  version = "1.03";

  src = fetchFromGitHub {
    owner = "werman";
    repo = pname;
    rev = "c1cf4307c75abed8e3ecccdd23a35f7782feaf69";
    sha256 = "sha256-1/HvGzk/WhzZ7Jg5bsRSV/dKZRSwYdvQCCqgXpIOgNs=";
  };

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [
    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXext
    xorg.libXcursor
    freetype
  ];

  cmakeFlags = [
    "-DBUILD_VST_PLUGIN=OFF"
    "-DBUILD_LV2_PLUGIN=OFF"
    "-DBUILD_VST3_PLUGIN=OFF"
    "-DBUILD_AU_PLUGIN=OFF"
    "-DBUILD_AUV3_PLUGIN=OFF"
    "-DBUILD_LADSPA_PLUGIN=ON"
    # Only build the ladspa plugin
  ];
}
