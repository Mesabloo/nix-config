{ config, options, lib, pkgs, ... }:

with lib;
{
  config = mkIf (config.modules.dev.emacs.enable
              || config.modules.dev.kakoune.enable) {
    home.packages = with pkgs; [
      editorconfig-core-c
    ];
  };
}
