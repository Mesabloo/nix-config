# Audio effects: equalizer, bass boost
# As a metalhead, I want to have some effects to make the music sound better.

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.services.sound.effects = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.sound.effects.enable {
    home.packages = with pkgs; [
      dconf

      gnome3.adwaita-icon-theme   # we need the icon theme else
                                  # all icons are missing in pulseeffects

      pulseeffects-legacy
    ];

    dconf.enable = true;
  };
}
