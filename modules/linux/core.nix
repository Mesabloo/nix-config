# Some useful core programs.

{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.linux.core = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.linux.core.enable {
    home.packages = with pkgs; [
      binutils
      coreutils
      cacert

      xdg-user-dirs
    ];
  };
}
