{ pkgs
, stdenv ? pkgs.stdenv
}:

let
  script = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/msaitz/polybar-bluetooth/master/bluetooth.sh;
    sha256 = "03gqz633001mbhj33c6a05g8mjqhm5s4rkbnz8f7x8fqxf0i18ss";
  };
  script-toggle = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/msaitz/polybar-bluetooth/master/toggle_bluetooth.sh;
    sha256 = "1km98913al0swsb50zn5f08aqwxsgasrm1nr2cgy9mvgj97ki2ic";
  };
  script-scan = pkgs.writeTextFile {
    name = "bluetooth.sh";
    text =
      builtins.replaceStrings
        ["#!/bin/sh"
         ""]
        [''
         #!${stdenv.shell}
         if ! command -v bluetoothctl &> /dev/null; then
           # bluetoothctl not found; bluetooth is not activated
           echo ""
           exit 0
         fi
         ''
         ""]
        (builtins.readFile script);
  };
in
pkgs.stdenv.mkDerivation rec {
  name = "polybar-bt";

  src = null;

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    install -m755 ${script-scan} $out/bin/bluetooth.sh
    install -m755 ${script-toggle} $out/bin/toggle_bluetooth.sh
  '';
}
