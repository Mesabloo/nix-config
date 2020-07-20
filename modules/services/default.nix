{ config, options, ... }:

{
  imports = [
    ./archive
    ./compton.nix
    ./deadd.nix
    ./dunst.nix
    ./fonts.nix
    ./net
    ./polybar.nix
    ./rofi.nix
    ./shell
    ./sound
  ];

  options = {};
  config = {};
}
