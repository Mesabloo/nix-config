{ pkgs, config, lib, options, ... }:

with lib;
{
  options.modules.apps.nautilus = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.nautilus.enable {
    home.packages = with pkgs; [
      gnome3.nautilus
      gnome3.sushi
      gvfs
    ];
  };
}
