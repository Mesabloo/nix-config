# I just feel the need to play something random sometimes, make gun powder explode,
# play with uranium, etc.

{ pkgs, lib, options, config, ... }:

with lib;
{
  options.modules.games.powder-toy = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.games.powder-toy.enable {
    home.packages = with pkgs; [
      the-powder-toy   # I can't believe this is made with the SDL
      glfw
      vulkan-loader
      SDL
      SDL2
    ];
  };
}
