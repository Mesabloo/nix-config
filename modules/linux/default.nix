{ config, options, ... }:

{
  imports = [
    ./core.nix
    ./nix-utils.nix
    ./utils.nix
  ];

  config = {};
  options = {};
}
