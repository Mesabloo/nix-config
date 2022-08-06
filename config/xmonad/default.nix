{ lib, pkgs, config, options, ... }:

with lib;
{
  config = mkIf config.modules.desktop.xmonad.enable {
    xsession.windowManager.xmonad = {
      enableContribAndExtras = true;
      extraPackages = ps: with ps; [
        containers
        xdg-basedir
        regex-tdfa
        directory
        filepath
      ];
      config = ./Config.hs;
      haskellPackages = pkgs.haskell.packages.ghc923;
    };

    modules.services.rofi.enable = mkDefault true;
    modules.services.picom.enable = mkDefault true;
    modules.services.polybar.enable = mkDefault true;
    modules.services.unipicker.enable = mkDefault true;
    modules.services.xob.enable = mkDefault true;

    home.packages = with pkgs; [
      betterlockscreen
      nitrogen
      brightnessctl
      pulseaudio
      polybar-scripts.player-mpris-tail
      xidlehook
      numlockx
    ];
  };
}
