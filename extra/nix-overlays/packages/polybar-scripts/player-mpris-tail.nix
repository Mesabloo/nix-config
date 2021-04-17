{ pkgs }:

let
  script = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/polybar/polybar-scripts/master/polybar-scripts/player-mpris-tail/player-mpris-tail.py;
    sha256 = "1nzvk4857wv2kcxf6h73hkf243py3ni0p86nb1kplyj5xf9s3xmr";
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
