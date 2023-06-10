{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "unipicker";
  version = "2.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "jeremija";
    repo = "unipicker";
    rev = "master";
    sha256 = "1k4v53pm3xivwg9vq2kndpcmah0yn4679r5jzxvg38bbkfdk86c1";
  };

  buildInputs = with pkgs; [
    gnumake
    perl
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share $out/etc
    make DESTDIR=$out PREFIX=$out install
  '';
}
