{ config, options, pkgs, lib, ... }:

with lib;
{
  options.modules.dev.agda = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.agda.enable {
    home.packages = with pkgs; [
      agda
      agda-pkg
    ];
  };
}
