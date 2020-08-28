{ pkgs }:

let
  script = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/polybar/polybar-scripts/master/polybar-scripts/player-mpris-tail/player-mpris-tail.py;
    sha256 = "0dbzc3wm0wgsi4xll66kg70g8iji3k95sr4hnq7wizzxvdqz9fg2";
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
