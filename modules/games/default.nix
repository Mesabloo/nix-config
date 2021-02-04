{ config, options, ... }:

{
  imports = [
    ./minecraft.nix
    ./powder-toy.nix
    ./void-space.nix
  ];

  config = {};
  options = {};
}
