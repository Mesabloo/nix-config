{ config, lib, ... }:

with lib;
{
  config = mkIf config.modules.services.rofi.enable {
    home.file =
      with builtins;
      let
        themes = readDir (sourceByRegex ./. ["$.*\\.rasi^"]).outPath;

        themes-config = mapAttrs'
          (name: val: nameValuePair ".config/rofi/themes/${name}" val)
          themes;
      in
      {
        ".config/rofi/config".source = ./config;
      } // themes-config;
  };
}
