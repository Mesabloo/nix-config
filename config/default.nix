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
    ./haskell.nix
    ./neuron.nix
    ./termite.nix
    ./zsh.nix
  ];
}
