{ config, pkgs, ... }:

{
  imports = [
    ./i3
    ./alacritty
    ./polybar
    ./rofi

    ./compton.nix
    ./dunst.nix
    ./git.nix
    ./haskell.nix
    ./neuron.nix
    ./termite.nix
    ./zsh.nix
  ];
}
