{ config, pkgs, ... }:

{
  imports = [
    ./i3
    ./polybar
    ./rofi

    ./compton.nix
    ./dunst.nix
    ./git.nix
    ./haskell.nix
    ./zsh.nix
  ];
}
