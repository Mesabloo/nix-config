{ config, lib, pkgs, ... }:

with lib;
{
  config = mkIf config.modules.services.rofi.enable {
    xdg.configFile =
      with builtins;
      let
        themes = readDir (sourceByRegex ./. ["^.*\\.rasi$"]).outPath;

        themes-config = mapAttrs'
          (name: _: nameValuePair "rofi/themes/${name}" { source = ./. + "/${name}"; })
          (filterAttrs (name: _: name != "config.rasi") themes);
      in
      {
        "rofi/config.rasi".source = ./config.rasi;
      } // themes-config;

    home.packages = with pkgs; [
      papirus-icon-theme
    ];

    modules.services.fonts.nerdfonts = {
      enable = mkDefault true;
      fonts = mkDefault [ "FantasqueSansMono" ];
    };
  };
}
