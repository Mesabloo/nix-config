# I just wanna see the background images I store on my computer.

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.nomacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.nomacs.enable {
    home.packages = with pkgs; [
      nomacs
    ];
  };
}
