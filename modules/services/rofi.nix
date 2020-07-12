# Almost better than dmenu in every way.

{ pkgs, options, config, lib, ... }:

with lib;
{
  options.modules.services.rofi = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    home.packages = with pkgs; [
      rofi
    ];
  };
}
