{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.evince = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.evince.enable {
    home.packages = with pkgs; [
      evince
      gvfs
      dconf
    ];
  };
}
