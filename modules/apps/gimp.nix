# Let's draw anything!

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.gimp = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
