{ lib, pkgs, config, options, ... }:

with lib;
{
  options.modules.desktop.xmonad = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.xmonad.enable {

    home.packages = with pkgs; [
      nitrogen   # saves and restores backgrounds
      numlockx   # automatically turns on NUMLOCK so that I don't have to

      nordic  # because we may lack icons for GTK apps
    ];

#    xsession.scriptPath = ".hm-xsession";

    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };
}
