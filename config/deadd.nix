{ pkgs, config, options, lib, ... }:

with lib;
{
  config = mkIf config.modules.services.deadd.enable {
    modules.services.deadd.settings = {
      notification-center = {
        width = 500;
        followMouse = true;
        configSendNotiClosedDbusMessage = true;
      };

      notification-center-notification-popup = {
        notiDefaultTimeout = 5000;
        width = 450;
        followMouse = true;
        iconSize = 20;
        maxImageSize = 0;
      };

      colors = {
        notiBackground = "rgba(63, 63, 63, 1)";
        critical = "rgba(63, 63, 63, 1)";
       
      };
    };
  };
}
