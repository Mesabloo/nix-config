# Sometimes I also want to make screencasts.

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.obs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.obs.enable {
    home.packages = with pkgs; [
      obs-studio
    ];
  };
}
