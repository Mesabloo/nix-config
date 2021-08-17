{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.services.autorandr = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.autorandr.enable {
    home.packages = with pkgs; [
      autorandr
    ];

    programs.autorandr.enable = true;
  };
}
