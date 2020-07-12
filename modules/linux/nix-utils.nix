# Some useful Nix programs.

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.linux.nix-utils = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.linux.nix-utils.enable {
    home.packages = with pkgs; [
      nix-index
    ];
  };
}
