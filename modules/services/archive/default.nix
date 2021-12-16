# I like to create archives.

{ config, options, lib, pkgs, ... }:

with lib;
{
  imports = [
    ./rar.nix
    ./tar.nix
    ./zip.nix
  ];

  options.modules.services.archive = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.archive.enable {
    modules.services.archive.rar.enable = true;
    modules.services.archive.tar.enable = true;
    modules.services.archive.zip.enable = true;

    home.packages = with pkgs; [
      ark
    ];
  };
}
