{ pkgs }:

let
  script = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/polybar/polybar-scripts/master/polybar-scripts/player-mpris-tail/player-mpris-tail.py;
    sha256 = "1hxqv377ysflh0y4fzxg17n9n34f9ypmkksi3ic5alflvkqx8dhm";
  };
in
pkgs.stdenv.mkDerivation rec {
  name = "player-mpris-tail";

  buildInputs = with pkgs; [
    (python38.withPackages (ps: with ps; [
      dbus-python
      pygobject3
    ]))
  ];

  src = null;

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp ${script} $out/bin/player-mpris-tail
    chmod +x $out/bin/player-mpris-tail
  '';
}
