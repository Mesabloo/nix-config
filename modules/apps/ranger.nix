{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.ranger = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.ranger.enable {
    home.packages = with pkgs; [
      ranger
    ];
  };
}

