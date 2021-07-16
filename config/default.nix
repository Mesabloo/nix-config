{ config, pkgs, ... }:

{
  imports = [
    ./i3.nix
    ./alacritty
    ./polybar
    ./rofi
    ./unipicker
    ./xmonad

    ./deadd.nix
    ./dunst.nix
    ./git.nix
    ./gtk.nix
    ./haskell.nix
    ./neuron.nix
    ./picom.nix
    ./qt.nix
    ./termite.nix
    ./x.nix
    ./zsh.nix
  ];
}
