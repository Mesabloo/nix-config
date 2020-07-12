{ config, options, ... }:

{
  imports = [
    ./flameshot.nix
    ./gimp.nix
    ./nomacs.nix
    ./obs.nix
    ./vlc.nix
  ];

  config = {};
  options = {};
}
