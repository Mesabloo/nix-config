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
    ];

    xsession.scriptPath = ".hm-xsession";

    xsession.windowManager.i3 = {
      enable = true;
    };
  };
}
