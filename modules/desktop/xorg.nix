# Those utils are more than useful. Most of them allow using my polybars.

{ pkgs, lib, options, config, ... }:

with lib;
{
  options.modules.desktop.xorg.utils = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.xorg.utils.enable {
    home.packages = with pkgs; [
      arandr             # xrandr frontend
      brightnessctl      # manipulate screen and keyboard backlight
      xorg.xev           # get event names
      xorg.xfd
      xorg.fontmiscmisc
      xdotool
    ];
  };
}
