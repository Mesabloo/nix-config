{ config, options, lib, pkgs, ... }:

with lib;
{
  config = mkIf config.modules.services.autorandr.enable {
    programs.autorandr.hooks = {
      postswitch =
        let reload-polybar = if config.modules.services.polybar.enable then {
              "reload-polybar" = ''
                echo "Reloading all polybars..."
                ${config.xdg.configHome}/polybar/launch.sh &> /dev/null
              '';
            } else {};
            reload-background = {
              "restore-background" = ''
                echo "Reloading wallpaper"
                ${pkgs.nitrogen}/bin/nitrogen --restore
              '';
            };
        in
          reload-polybar // reload-background;
    };
  };
}
