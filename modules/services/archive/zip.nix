# *.zip archive manipulation, although it is for heretics.

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.services.archive.zip = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.archive.zip.enable {
    home.packages = with pkgs; [
      zip
      unzip
    ];
  };
}
