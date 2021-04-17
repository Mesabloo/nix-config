{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "ats-acc";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "sparverius";
    repo = "ats-acc";
    rev = "master";
    sha256 = "1k7y237bx04smlnh7yhgqqzgjbl6f2i2jy5a30sbwd0qrzizv7as";
  };

  buildInputs = with pkgs; [
    gnumake

    ats2
  ];

  configurePhase = ''
    sed -i '1i PREFIX ?=' Makefile
    sed -ir 's/mv acc $(PATSHOME)/install -m755 acc $(PREFIX)/' Makefile

cat Makefile
  '';

  installPhase = ''
    mkdir -p $out/bin
    make PREFIX=$out install
  '';
}
