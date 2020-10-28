# Well, now I use i3.

{ lib, pkgs, config, options, ... }:

with lib;
{
  options.modules.desktop.i3 = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.i3.enable {

    home.packages = with pkgs; [
      nitrogen   # saves and restores backgrounds
      numlockx   # automatically turns on NUMLOCK so that I don't have to

      gnome3.adwaita-icon-theme  # because we may lack icons for GTK apps
    ];

    xsession.scriptPath = ".hm-xsession";

    xsession.windowManager.i3 = {
      enable = true;
    };
  };
}
