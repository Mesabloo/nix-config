{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "pulse-listener";
  version = "1.0.0";

	src = null;

	unpackPhase = ":";

  buildInputs = with pkgs; [
    (python38.withPackages (ps: with ps; [ pulsectl ]))
  ];

	installPhase = ''
	  mkdir -p $out/bin
	  cp ${./pulse-listener.py} $out/bin/pulse-listener
	  chmod +x $out/bin/pulse-listener
	'';
}

