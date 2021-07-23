{ lib, pkgs, config, options, ... }:

with lib;
{
  config = mkIf config.modules.desktop.xmonad.enable {
    xsession.windowManager.xmonad = {
      extraPackages = ps: with ps; [
        containers
        xdg-basedir
        regex-tdfa
      ];
      config = ./Config.hs;
      haskellPackages = pkgs.haskell.packages.ghc884;
    };

    modules.services.rofi.enable = mkDefault true;
    modules.services.picom.enable = mkDefault true;
    modules.services.polybar.enable = mkDefault true;
    modules.services.unipicker.enable = mkDefault true;

    home.packages = with pkgs; [
      betterlockscreen
      nitrogen
      brightnessctl
      pulseaudio
      polybar-scripts.player-mpris-tail
      xidlehook
    ];
  };
}
