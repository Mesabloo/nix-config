{ pkgs
, stdenv ? pkgs.stdenv
}:

let
  true_ = "${pkgs.coreutils}/bin/true";
  false_ = "${pkgs.coreutils}/bin/false";
  bluetoothctl = "${pkgs.bluez}/bin/bluetoothctl";
  wc = "${pkgs.coreutils}/bin/wc";
  echo = "${pkgs.coreutils}/bin/echo";
  grep = "${pkgs.gnugrep}/bin/grep";

  script = pkgs.writeTextFile {
    name = "bluetooth.sh";
    text = ''
      #!${stdenv.shell}

      # if ! command ${bluetoothctl} 2>/dev/null; then
      #    # bluetoothctl is unavailable
      #    # This only happens if `hardware.bluetooth.enable` is set to `false`
      #    # as Nix installs the required packages itself.
      #    exit 0
      # fi

      ICON=""
      DISABLED="%{F#66ffffff}$ICON"
      ENABLED="$ICON"
      CONNECTED="%{F#2193ff}$ICON"

      if (( $# > 0 )); then
          DISABLED=$1
          shift
      fi
      if (( $# > 0 )); then
          ENABLED=$1
          shift
      fi
      if (( $# > 0 )); then
          CONNECTED=$1
          shift
      fi

      if [ $(${bluetoothctl} show | ${grep} 'Powered: yes' | ${wc} -c) -eq 0 ]; then
          ${echo} $DISABLED
      elif [ $(${bluetoothctl} <<< 'info' | ${grep} 'Device' | ${wc} -c) -eq 0 ]; then
          ${echo} $ENABLED
      else
          ${echo} $CONNECTED
      fi
    '';
  };
  script-toggle = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/msaitz/polybar-bluetooth/master/toggle_bluetooth.sh;
    sha256 = "1km98913al0swsb50zn5f08aqwxsgasrm1nr2cgy9mvgj97ki2ic";
  };
in
pkgs.stdenv.mkDerivation rec {
  name = "polybar-bt";

  src = null;

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    install -m755 ${script} $out/bin/bluetooth.sh
    install -m755 ${script-toggle} $out/bin/toggle_bluetooth.sh
  '';
}
