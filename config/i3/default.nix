{ lib, config, pkgs, ... }:

with lib;
{
  config = mkIf config.modules.desktop.i3.enable {
    xsession.windowManager.i3 =
      let
        mod = "Mod4";
      in {
        config = {
          modifier = mod;

          fonts = [ "pango:FontAwesome 12" ];

          keybindings =
            let
              brightnessctl-device = "${pkgs.brightnessctl}/bin/brightnessctl --list | ${pkgs.gnugrep}/bin/grep kbd | ${pkgs.gawk}/bin/awk '{print $11}' | ${pkgs.coreutils}/bin/cut -d\"'\" -f2";
            in
            mkOptionDefault {
            "${mod}+Print" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui";
            "${mod}+Return" = "exec --no-startup-id ${pkgs.coreutils}/bin/env WINIT_X11_SCALE_FACTOR=1 ${config.modules.services.shell.emulator}/bin/*";
            "${mod}+d" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi -show run";
            "${mod}+Ctrl+Left" = "move workspace to output left";
            "${mod}+Ctrl+Right" = "move workspace to output right";
            "${mod}+l" = "exec ${pkgs.i3lock}/bin/i3lock -i $HOME/.wallpapers/lock.png -t";
            "${mod}+Shift+F" = "floating enable, sticky enable";

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
            "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 5%+";
            "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
            "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +4%";
            "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -4%";
            "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86KbdBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl --device=$(${brightnessctl-device}) s 1+";
            "XF86KbdBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl --device=$(${brightnessctl-device}) s 1-";
          };

          bars = [ { mode = "invisible"; } ];
        };

        extraConfig =
          with builtins;
          readFile ./config;
      };
  };
}
