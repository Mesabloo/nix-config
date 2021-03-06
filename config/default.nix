{ config, pkgs, ... }:

{
  imports = [
    ./i3.nix
    ./alacritty
    ./polybar
    ./rofi
    ./unipicker

    ./compton.nix
    ./deadd.nix
    ./dunst.nix
    ./git.nix
    ./gtk.nix
    ./haskell.nix
    ./neuron.nix
    ./qt.nix
    ./termite.nix
    ./x.nix
    ./zsh.nix
  ];
}
