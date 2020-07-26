{ config, options, ... }:

{
  imports = [
    ./flameshot.nix
    ./gimp.nix
    ./nomacs.nix
    ./obs.nix
    ./okular.nix
    ./vlc.nix
  ];

  config = {};
  options = {};
}
