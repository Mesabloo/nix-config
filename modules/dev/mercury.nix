{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.dev.mercury = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.mercury.enable {
    home.packages = with pkgs; [
      mercury
    ];
  };
}
