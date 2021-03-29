{ config, options, ... }:

{
  imports = [
    ./archive
    ./asciinema.nix
    ./compton.nix
    ./deadd.nix
    ./dunst.nix
    ./fonts.nix
    ./net
    ./neuron.nix
    ./oracle-xe.nix
    ./polybar.nix
    ./rofi.nix
    ./shell
    ./sound
    ./unipicker.nix
  ];

  options = {};
  config = {};
}
