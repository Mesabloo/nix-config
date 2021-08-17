{ config, options, lib, pkgs, ... }:

with lib;
{
  config = mkIf config.modules.services.autorandr.enable {
    programs.autorandr.hooks = {
      postswitch = mkIf config.modules.services.polybar.enable {
        "reload-polybar" = "${config.xdg.configHome}/polybar/launch.sh";
      } // {
        "restore-background" = "${pkgs.nitrogen}/bin/nitrogen --restore &";
      };
    };
  };
}
