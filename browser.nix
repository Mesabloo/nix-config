{ config, options, lib, pkgs, unstable, ... }:

{
  home = {
    packages = with pkgs; [
      unstable.brave
    ];
    sessionVariables."BROWSER" = "brave";
  };
}
