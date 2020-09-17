{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.apps.office = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.office.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  };
}
