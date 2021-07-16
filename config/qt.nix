{ config, pkgs, ... }:

{
  config = {
    qt.enable = true;

    qt.platformTheme = "gtk";

    home.packages = with pkgs; [
      libsForQt5.qtstyleplugins
    ];
  };
}
