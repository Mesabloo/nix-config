{ config, options, ... }:

{
  imports = [
    ./archive
    ./asciinema.nix
    ./deadd.nix
    ./dunst.nix
    ./fonts.nix
    ./net
    ./neuron.nix
    ./oracle-xe.nix
    ./picom.nix
    ./polybar.nix
    ./rofi.nix
    ./shell
    ./sound
    ./unipicker.nix
    ./wallet
    ./xmobar.nix
  ];

  options = {};
  config = {};
}
