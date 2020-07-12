{ lib, config, ... }:

{
  config = lib.mkIf config.modules.desktop.i3.enable {
    xsession.windowManager.i3 =
      let
        mod = "Mod4";
      in {
        config = {
          modifier = mod;

          fonts = [ "pango:FontAwesome 12" ];

          keybindings = lib.mkOptionDefault {
            "${mod}+Print" = "exec flameshot gui";
            "${mod}+Return" = "exec termite";
            "${mod}+d" = "exec rofi -show run";
            "${mod}+Ctrl+Left" = "move workspace to output left";
            "${mod}+Ctrl+Right" = "move workspace to output right";

            # Special keys
            "XF86MonBrightnessUp" = "exec brightnessctl s 5%+";
            "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
            "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +4%";
            "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -4%";
            "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86KbdBrightnessUp" = "exec brightnessctl --device=$(brightnessctl --list | grep kbd | cut -d\" \" -f2 | cut -d\"'\" -f2) s 1+";
            "XF86KbdBrightnessDown" = "exec brightnessctl --device=$(brightnessctl --list | grep kbd | cut -d\" \" -f2 | cut -d\"'\" -f2) s 1-";
          };

          bars = [ { mode = "invisible"; } ];
        };

        extraConfig =
          with builtins;
          readFile ./config;
      };
  };
}
