{ config, pkgs, ... }:

{
  config = {
    qt.enable = true;

    qt.platformTheme = "gtk";

    qt.style = {
      package = pkgs.nordic;
      name = "gtk2";
    };

    home.packages = with pkgs; [
      libsForQt5.qtstyleplugins
    ];
  };
}
