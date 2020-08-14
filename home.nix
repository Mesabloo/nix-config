{ config, options, pkgs, ... }:

{
  require = [ ./extra/nix-overlays ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules
    ./config
  ];

  #################################################################

  modules.desktop.i3.enable = true;
  modules.desktop.xorg.utils.enable = true;

  modules.dev.agda.enable = true;
  modules.dev.cpp.enable = true;
  modules.dev.emacs.enable = true;
  modules.dev.haskell.enable = true;
  modules.dev.rust.enable = true;
  modules.dev.python.enable = true;
  modules.dev.vscode.enable = true;

  modules.services.fonts = {
    enable = true;
    iosevka.enable = true;
    font_awesome.enable = true;
  };

  modules.net.brave = {
    enable = true;
    defaultBrowser = true;
  };

  modules.dev.git.enable = true;

  modules.games.powder-toy.enable = true;

  modules.linux.core.enable = true;
  modules.linux.nix-utils.enable = true;
  modules.linux.utils.enable = true;

  modules.social.discord.enable = true;

  # modules.services.dunst.enable = true;
  modules.services.deadd.enable = true;
  modules.services.polybar.enable = true;
  modules.services.rofi.enable = true;

  modules.services.shell.emulator = pkgs.alacritty;
  modules.services.shell.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
  };

  modules.services.compton.enable = true;

  modules.services.sound = {
    enable = true;
    effects.enable = true;
  };

  modules.services.archive.enable = true;

  modules.services.neuron.enable = true;

  modules.apps = {
    audacity.enable = true;
    flameshot.enable = true;
    gimp.enable = true;
    nomacs.enable = true;
    obs.enable = true;
    okular.enable = true;
    pandoc.enable = true;
    vlc.enable = true;
  };

  ############################################################################""

  programs.home-manager = {
    enable = true;
    path = "https://github.com/rycee/home-manager/archive/release-20.03.tar.gz";
  };
}

