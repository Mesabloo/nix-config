# I don't want to use the TTY at all.

{ lib, pkgs, options, config, ... }:

with lib;
{
  options.modules.services.shell = {
    emulator = mkOption {
      type = with types; nullOr package;
      default = null;
    };
  };

  config = {
    home.packages = mkIf (config.modules.services.shell.emulator != null) [
      config.modules.services.shell.emulator
    ];
  };
}
