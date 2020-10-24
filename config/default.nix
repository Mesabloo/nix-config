{ config, pkgs, ... }:

{
  imports = [
    ./i3
    ./alacritty
    ./polybar
    ./rofi

    ./compton.nix
    ./deadd.nix
    ./dunst.nix
    ./git.nix
    ./gtk.nix
    ./haskell.nix
    ./neuron.nix
    ./termite.nix
    ./x.nix
    ./zsh.nix
  ];
}
