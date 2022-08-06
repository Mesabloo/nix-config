{ config, pkgs, ... }:

{
  xsession.enable = true;

  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 30;

    x11 = {
      defaultCursor = "default";
      enable = true;
    };
  };

  xresources.extraConfig = ''
    #include "${pkgs.nord-xresources}/share/nord"
  '';

  xsession.numlock.enable = true;

  xsession.initExtra = ''
    #xsetroot -cursor_name left_ptr
    setxkbmap fr
    setxkbmap -option compose:rctrl

    ${pkgs.ibus}/bin/ibus-daemon -drxR
  '';

  xsession.profileExtra = ''
    # export XMODIFIERS="@im=uim"
    # export XMODIFIER="@im=uim"
    # export GTK_IM_MODULE=uim
    # export QT_IM_MODULE=uim
    # export QT4_IM_MODULE=uim
  '';

  home.packages = [ pkgs.ibus ];
  home.file.".XCompose".source = ./XCompose;
}
