{ config, options, ... }:

{
  imports = [
    ./audacity.nix
    ./flameshot.nix
    ./gimp.nix
    ./nomacs.nix
    ./obs.nix
    ./office.nix
    ./okular.nix
    ./pandoc.nix
    ./teams.nix
    ./vlc.nix
  ];

  config = {};
  options = {};
}
