{ config, pkgs, ... }:

{
  xsession.enable = true;

  xsession.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 30;
    defaultCursor = "default";
  };

  xresources.extraConfig = ''
    #include "${pkgs.nord-xresources}/share/nord"
  '';

  xsession.numlock.enable = true;

  xsession.initExtra = ''
    #xsetroot -cursor_name left_ptr
    setxkbmap fr

    export PATH="$PATH:$HOME/.local/bin"
  '';
}
