{ config, options, lib, pkgs, ... }:

with lib;
{
  config = mkIf config.modules.services.unipicker.enable {
    home.file.".unipickerrc".text =
      let
        postProcess = builtins.replaceStrings
          [ "##ROFI##" "##SYMBOLS##" ]
          [ "${pkgs.rofi}/bin/rofi -dmenu" "${pkgs.unipicker}/share/unipicker/symbols" ];
      in postProcess (builtins.readFile ./unipickerrc);
  };
}
