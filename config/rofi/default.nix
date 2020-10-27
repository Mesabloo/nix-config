{ config, lib, ... }:

with lib;
{
  config = mkIf config.modules.services.rofi.enable {
    home.file =
      with builtins;
      let
        themes = readDir (sourceByRegex ./. ["^.*\\.rasi$"]).outPath;

        themes-config = mapAttrs'
          (name: _: nameValuePair ".config/rofi/themes/${name}" { source = ./. + "/${name}"; })
          (filterAttrs (name: _: name != "config.rasi") themes);
      in
      {
        ".config/rofi/config.rasi".source = ./config.rasi;
      } // themes-config;
  };
}
