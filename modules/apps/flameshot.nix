# Sometimes, I may want to take screenshots...

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.flameshot = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.flameshot.enable {
    home.packages = with pkgs; [
      flameshot
    ];
  };
}
