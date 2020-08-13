{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.audacity = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.audacity.enable {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
