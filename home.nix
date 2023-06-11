{ config, options, pkgs, lib, ... }:

with lib;
{
  nixpkgs.overlays = [
    (import ./packages)
  ];

  imports = [
    ./desktop.nix
    ./browser.nix
    ./social.nix
    ./shell.nix
    ./sound.nix
    ./systemd-services.nix
    ./config/ssh.nix
    ./config/git.nix
    ./kakoune.nix
  ];

  programs.obs-studio.enable = true;
  dconf.enable = true;

  nixpkgs.config = import ./config.nix { inherit pkgs; };

  home = rec {
    username = "mesabloo";
    stateVersion = "22.11";
    homeDirectory = "/home/${username}";

    # Remove at the end!
    packages = with pkgs; [
      evince
      gvfs
      dconf
      
      gnome.nautilus

      vlc

      libreoffice-qt

      libsForQt5.ark
      zip
      unzip
      btar
      gnutar
      unrar

      nix-prefetch-scripts
      nix-direnv

      bat
      cloc
      dialog
      file
      hyperfine
      mount-helper
      neofetch
      psmisc
      tree

      binutils
      coreutils
      xdg-user-dirs

      nomacs

      wineWowPackages.stable
      winetricks

      nixpkgs-fmt
      rnix-lsp
    ];
  };
}
