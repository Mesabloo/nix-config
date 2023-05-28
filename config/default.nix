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
    ./kitty.nix
    ./neuron.nix
    ./picom.nix
    ./qt.nix
    ./sound.nix
    ./systemd.nix
    ./termite.nix
    ./x.nix
    ./xob.nix
    ./zsh.nix
  ];
}
