{ lib, config, pkgs, ... }:

{
  config = lib.mkIf config.modules.services.polybar.enable {
    home.file = {
      ".config/polybar/launch.sh".source = ./launch.sh;

      ".config/polybar/config".text =
        with lib; with builtins;
        let
          currentPath = ./.;
          files = attrNames (readDir (sourceByRegex currentPath ["^.*\\.ini$"]).outPath);
          fileToStr = f: "${readFile "${currentPath}/${f}"}\n";

          postProcess = builtins.replaceStrings
            ["##PLAYER_MPRIS_TAIL##"                                           "##UPTIME##"]
            ["${pkgs.polybar-scripts.player-mpris-tail}/bin/player-mpris-tail" "${pkgs.polybar-scripts.system-uptime}/bin/system-uptime"];
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
