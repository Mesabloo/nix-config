# Quick and mostly ugly notifications.

{ pkgs, options, config, lib, ... }:

with lib;
{
  options.modules.services.dunst = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.dunst.enable {
    home.packages = with pkgs; [
      dunst
      libnotify
    ];

    services.dunst = {
      enable = true;
    };
  };
}
