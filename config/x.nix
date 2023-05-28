{ config, pkgs, lib, ... }:

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
    export GTK_THEME=Nordic
  '';

  home.packages = [ pkgs.ibus ];
  home.file.".XCompose".source = ./XCompose;

  systemd.user.services.setxkbmap = {
    Service.ExecStart = lib.mkForce "${pkgs.coreutils}/bin/true";
  };

  services.xidlehook = {
    enable = true;
    detect-sleep = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    timers = [
      {
        delay = 300;
        command = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
      }
      {
        delay = 3600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
