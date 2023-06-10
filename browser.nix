{ config, options, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      brave
    ];
    sessionVariables."BROWSER" = "brave";
  };
}