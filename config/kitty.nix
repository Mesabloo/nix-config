{ lib, config, pkgs, ... }:

let
  nord-kitty = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/m8mble/nord-kitty/feaf90256a3c9d4e85b8cf03f5eb3e3d0aa2fa59/nord-kitty.conf";
    sha256 = "1dgpsgzmjms03980ql4pj7ff44bp9bc1fig19bisw4kls7akk5gl";
  };

in
with lib;
{
  config = mkIf (config.modules.services.shell.emulator == pkgs.kitty) {
    programs.kitty = {
      enable = true;

      font = {
        package = null;
        name = "Iosevka Nerd Font Mono";
        size = 10;
      };

      extraConfig = ''
        include ${nord-kitty}

        map ctrl+enter launch --location=vsplit
        map ctrl+shift+enter launch --location=hsplit

        map shift+up neighboring_window up
        map shift+left neighboring_window left
        map shift+right neighboring_window right
        map shift+down neighboring_window down

        map ctrl+shift+up move_window up
        map ctrl+shift+left move_window left
        map ctrl+shift+right move_window right
        map ctrl+shift+down move_window down
      '';

      settings = {
        allow_remote_control = "yes";
        enabled_layouts = "splits:split_axis=horizontal";
        
        disable_ligatures = "always";
        
        scrollback_lines = 2000;

        window_padding_width = 10;

        enable_audio_bell = "no";
        window_alert_on_bell = "no";
        bell_on_tab = "no";

        ### colors 
#        foreground = "#D8DEE9";
#        background = "#2E3440";
#        background_opacity = "1.0";

#        selection_foreground = "#D8DEE9"; # reversed
#        selection_background = "#2E3440"; # reversed
#        url_color = "#81A1C1";

        # cursor
#        cursor = "#E5E9F0";
#        cursor_text_color = "#E5E9F0";
        cursor_shape = "block";
        cursor_blink_interval = 0;

        # black
#        color0 = "#3E4252";
#        color8 = "#4C566A";
        # red
#        color1 = "#BF616A";
#        color9 = "#BF616A";
        # green
#        color2 = "#A3BE8C";
#        color10 = "#A3BE8C";
        # yellow
#        color3 = "#EBCB8B";
#        color11 = "#EBCB8B";
        # blue
#        color4 = "#81A1C1";
#        color12 = "#81A1C1";
        # magenta
#        color5 = "#B48EAD";
#        color13 = "#B48EAD";
        # cyan
#        color6 = "#88C0D0";
#        color14 = "#88C0D0";
        # white
#        color7 = "#E5E9F0";
#        color15 = "#ECEFF4";
      };
    };

    modules.services.fonts.nerdfonts = {
      enable = mkDefault true;
      fonts = mkDefault [ "Iosevka" ];
    };
  };
}
