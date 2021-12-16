# tar.* archive manipulation, even though it should already be present
# on the system.

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.services.archive.rar = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.archive.rar.enable {
    home.packages = with pkgs; [
      unrar
    ];
  };
}
