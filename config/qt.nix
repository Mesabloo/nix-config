{ config, pkgs, ... }:

{
  config = {
    qt.enable = true;

    qt.platformTheme = "gtk";
  };
}
