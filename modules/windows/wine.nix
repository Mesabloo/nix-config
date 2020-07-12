# I'm on linux. I don't know why I would execute random Windows
# applications here, but just in case...

{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.windows.wine = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.windows.wine.enable {
    home.packages = with pkgs; [
      wine
      winetricks   # Configure wine, but with a windows XP window style
    ];
  };
}
