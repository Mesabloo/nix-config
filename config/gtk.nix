{ config, pkgs, ... }:

{
  config = {
    gtk.enable = true;

    gtk.theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };

    gtk.gtk3.extraConfig = {
      gtk-cursor-theme-name = "capitaine-cursors";
      gtk-cursor-theme-size = 30;
      gtk-application-prefer-dark-theme = 1;
    };

    gtk.iconTheme = {
      package = pkgs.nordic;
      name = "Nordic";
    };

    gtk.font = {
      package = null;
      name = "Sans Serif Regular 10";
    };

    home.packages = with pkgs; [
      capitaine-cursors
      gtk_engines
      gnome3.gnome-themes-extra
    ];

    /*
    xdg.configFile."gtk-3.0/settings.ini".text = ''
      gtk-theme-name="Breeze"
      gtk-icon-theme-name="breeze"
      gtk-font-name="Sans Serif  10"
      gtk-cursor-theme-name="capitaine-cursors"
      gtk-cursor-theme-size=24
      gtk-toolbar-style=GTK_TOOLBAR_ICONS
      gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
      gtk-button-images=1
      gtk-menu-images=1
      gtk-enable-event-sounds=1
      gtk-enable-input-feedback-sounds=1
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    ''; */
  };
}
