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
            "${mod}+Print" = "exec --no-startup-id flameshot gui";
            "${mod}+Return" = "exec --no-startup-id env WINIT_X11_SCALE_FACTOR=1 ${config.modules.services.shell.emulator}/bin/*";
            "${mod}+d" = "exec --no-startup-id rofi -show run";
            "${mod}+Ctrl+Left" = "move workspace to output left";
            "${mod}+Ctrl+Right" = "move workspace to output right";
            "${mod}+l" = "exec i3lock -i $HOME/.wallpapers/lock.png -t";

            "${mod}+1" = "workspace number 1";
            "${mod}+2" = "workspace number 2";
            "${mod}+3" = "workspace number 3";
            "${mod}+4" = "workspace number 4";
            "${mod}+5" = "workspace number 5";
            "${mod}+6" = "workspace number 6";
            "${mod}+7" = "workspace number 7";
            "${mod}+8" = "workspace number 8";
            "${mod}+9" = "workspace number 9";
            "${mod}+Shift+1" = "move container to workspace number 1";
            "${mod}+Shift+2" = "move container to workspace number 2";
            "${mod}+Shift+3" = "move container to workspace number 3";
            "${mod}+Shift+4" = "move container to workspace number 4";
            "${mod}+Shift+5" = "move container to workspace number 5";
            "${mod}+Shift+6" = "move container to workspace number 6";
            "${mod}+Shift+7" = "move container to workspace number 7";
            "${mod}+Shift+8" = "move container to workspace number 8";
            "${mod}+Shift+9" = "move container to workspace number 9";

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
