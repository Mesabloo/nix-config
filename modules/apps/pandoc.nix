{ config, pkgs, options, lib, ... }:

with lib;
{
  options.modules.apps.pandoc = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.pandoc.enable {
    home.packages = with pkgs; [
      pandoc
    ];
  };
}
