{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.apps.okular = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.okular.enable {
    home.packages = with pkgs; [
      okular
    ];
  };
}
