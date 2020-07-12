# A simple compositor, with great effects.

{ pkgs, lib, options, config, ... }:

with lib;
{
  options.modules.services.compton = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.compton.enable {
    services.picom.enable = true;

    home.packages = with pkgs; [
      compton
    ];
  };
}
