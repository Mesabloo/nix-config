{ config, options, pkgs, lib, ... }:

with lib;
{
  options.modules.games.void-space = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.games.void-space.enable {
    home.packages = with pkgs; [
      void-space
    ];
  };
}
