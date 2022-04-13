{ config, options, ... }:

{
  imports = [
    ./audacity.nix
    ./evince.nix
    ./flameshot.nix
    ./gimp.nix
    ./nautilus.nix
    ./nomacs.nix
    ./obs.nix
    ./office.nix
    ./okular.nix
    ./pandoc.nix
    ./ranger.nix
    ./teams.nix
    ./vlc.nix
  ];

  config = { };
  options = { };
}

