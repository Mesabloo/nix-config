# Great for seeing movies.

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.vlc = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
