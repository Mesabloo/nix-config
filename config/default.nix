{ config, pkgs, ... }:

{
  imports = [
    ./i3.nix
    ./alacritty
    ./kakoune
    ./polybar
    ./rofi
    ./unipicker
    ./xmonad

    ./autorandr.nix
    ./deadd.nix
    ./dunst.nix
    ./editor.nix
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
