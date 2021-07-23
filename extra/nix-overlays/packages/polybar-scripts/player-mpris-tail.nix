{ pkgs }:

let
  script = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/polybar/polybar-scripts/master/polybar-scripts/player-mpris-tail/player-mpris-tail.py;
    sha256 = "1224av16pczkxzavvmqaj63mpyjqzimfrk8br9vi0hpmdda6xxva";
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
