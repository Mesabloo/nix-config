{ lib, config, pkgs, ... }:

with lib;
let
  patchFile =
    filePath: toReplace: replaceWith:
    pkgs.writeTextFile {
      name = "${filePath}";
      text = builtins.replaceStrings toReplace replaceWith (builtins.readFile filePath);
    };

  polybar-config-wminfo = pkgs.writeTextFile {
    name = "polybar-config-wminfo";
    text = concatStrings [ (builtins.readFile ./colors.ini) (builtins.readFile ./common.ini) (builtins.readFile ./wminfo.ini) ];
  };
  polybar-config-sysinfo = pkgs.writeTextFile {
    name = "polybar-config-sysinfo";
    text = builtins.replaceStrings
      ["##POLYBAR_BLUETOOTH##" "##PLAYER_MPRIS_TAIL##"]
      ["${pkgs.polybar-scripts.bluetooth}" "${pkgs.polybar-scripts.player-mpris-tail}/bin/player-mpris-tail"]
      (concatStrings [ (builtins.readFile ./colors.ini) (builtins.readFile ./common.ini) (builtins.readFile ./systeminfo.ini) ]);
  };
in
{
  config = mkIf (config.modules.services.polybar.enable && config.modules.desktop.xmonad.enable) {
    xdg.configFile = {
      "polybar/launch.sh" = {
        source = patchFile ./launch.sh
          ["##POLYBAR-WMINFO##" "##POLYBAR-SYSINFO##"]
          ["${polybar-config-wminfo}" "${polybar-config-sysinfo}"];
        executable = true;
      };
    };

    home.packages = with pkgs; [
      xcbutilxrm
    ];

    modules.services.fonts.font_awesome.enable = mkDefault true;
    modules.services.fonts.nerdfonts = {
      enable = mkDefault true;
      fonts = mkDefault [ "Iosevka" "MPlus" ];
    };
  };
}
