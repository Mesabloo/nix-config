{ pkgs }:

let
  script = pkgs.writeScript "system-uptime" ''
    #!${pkgs.stdenv.shell}

    TIME=$(${pkgs.coreutils}/bin/uptime | ${pkgs.coreutils}/bin/cut -d ' ' -f 7 | sed "s/,//")
    HOURS=$(${pkgs.coreutils}/bin/echo $TIME | ${pkgs.coreutils}/bin/cut -d ':' -f 1)
    MINS=$(${pkgs.coreutils}/bin/echo $TIME | ${pkgs.coreutils}/bin/cut -d ':' -f 2)

    echo "$1''${HOURS}h ''${MINS}m"
  '';
in
pkgs.stdenv.mkDerivation {
  name = "system-uptime";
  src = null;

  buildInputs = with pkgs; [
    coreutils
  ];

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp ${script} $out/bin/system-uptime
    chmod +x $out/bin/system-uptime
  '';
}
