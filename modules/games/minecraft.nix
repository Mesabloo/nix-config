{ pkgs, lib, options, config, ... }:

with lib;
{
  options.modules.games.minecraft = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.games.minecraft.enable {
    home.packages = with pkgs; [
      minecraft   # Comes batteries included
    ];
  };
}
