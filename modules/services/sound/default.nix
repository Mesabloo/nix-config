# WHo would have thought listening to music needed sound control?

{ config, options, lib, pkgs, ... }:

with lib;
{
  imports = [
    ./pulseeffects.nix
  ];

  options.modules.services.sound = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.sound.enable {
    home.packages = with pkgs; [
      pavucontrol
    ];
  };
}
