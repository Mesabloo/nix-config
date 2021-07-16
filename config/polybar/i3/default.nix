{ lib, config, pkgs, ... }:

with lib;
{
  config = mkIf (config.modules.services.polybar.enable && config.modules.desktop.i3.enable) {
    xdg.configFile = {
      "polybar/launch.sh" = {
        source = ./launch.sh;
        executable = true;
      };

      "polybar/config".text =
        with builtins;
        let
          currentPath = ./.;
          files = attrNames (readDir (sourceByRegex currentPath ["^.*\\.ini$"]).outPath);
          fileToStr = f: "${readFile "${currentPath}/${f}"}\n";

          postProcess = builtins.replaceStrings
            ["##PLAYER_MPRIS_TAIL##"
             "##UPTIME##"
             "##POLYBAR_BLUETOOTH##"]
            ["${pkgs.polybar-scripts.player-mpris-tail}/bin/player-mpris-tail"
             "${pkgs.polybar-scripts.system-uptime}/bin/system-uptime"
             "${pkgs.polybar-scripts.bluetooth}"];
        in
          postProcess (concatMapStrings fileToStr files);
    };
  };
}


/*
;==========================================================
;
;
;   ██████╗  ██████╗ ██╗  ██╗   ██╗██████╗  █████╗ ██████╗
;   ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
;   ██████╔╝██║   ██║██║   ╚████╔╝ ██████╔╝███████║██████╔╝
;   ██╔═══╝ ██║   ██║██║    ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗
;   ██║     ╚██████╔╝███████╗██║   ██████╔╝██║  ██║██║  ██║
;   ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
;
;
;   To learn more about how to configure Polybar
;   go to https://github.com/jaagr/polybar
;
;   The README contains alot of information
;
;==========================================================
*/
