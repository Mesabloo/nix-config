{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "brightness-listener";
  version = "1.0.0";

	src = null;

	unpackPhase = ":";

  buildInputs = with pkgs; [
    (python38.withPackages (ps: with ps; [ watchdog ]))
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${./brightness-listener.py} $out/bin/brightness-listener
    chmod +x $out/bin/brightness-listener
  '';
}
