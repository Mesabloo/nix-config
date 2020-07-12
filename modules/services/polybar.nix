# What a beauty of a bar.

{ pkgs, config, options, lib, ... }:

with lib;
{
  options.modules.services.polybar = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.polybar.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      polybar = pkgs.polybar.override {
        i3GapsSupport = true;
        pulseSupport = true;
      };
    };

    home.packages = with pkgs; [
      polybar
    ];
  };
}
