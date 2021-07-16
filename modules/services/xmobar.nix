{ pkgs, config, options, lib, ... }:

with lib;
{
  options.modules.services.xmobar = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.xmobar.enable {
    home.packages = with pkgs; [
      xmobar
    ];
  };
}
