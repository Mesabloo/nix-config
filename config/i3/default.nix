{ lib, config, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).config;
in
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
              grep = "${pkgs.gnugrep}/bin/grep";
              awk = "${pkgs.gawk}/bin/awk";
              brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
              flameshot = "${pkgs.flameshot}/bin/flameshot";
              env = "${pkgs.coreutils}/bin/env";
              rofi = "${pkgs.rofi}/bin/rofi";
              betterlockscreen = "${pkgs.betterlockscreen}/bin/betterlockscreen";
              sed = "${pkgs.gnused}/bin/sed";
              cat = "${pkgs.coreutils}/bin/cat";
              i3-msg = "${sysconfig.services.xserver.windowManager.i3.package}/bin/i3-msg";
              pactl = "${pkgs.pulseaudio}/bin/pactl";
              column = "${pkgs.utillinux}/bin/column";

              brightnessctl-device = "${brightnessctl} --list | ${grep} kbd | ${awk} '{print $2}' | ${sed} -e \"s/'//g\"";
            in
            mkOptionDefault {
            "${mod}+Print" = "exec --no-startup-id ${flameshot} gui";
            "${mod}+Return" = "exec --no-startup-id ${env} WINIT_X11_SCALE_FACTOR=1 ${config.modules.services.shell.emulator}/bin/*";
            "${mod}+d" = "exec --no-startup-id ${rofi} -show drun";
            "${mod}+Tab" = "exec --no-startup-id ${rofi} -show window";
            "${mod}+Ctrl+Left" = "move workspace to output left";
            "${mod}+Ctrl+Right" = "move workspace to output right";
            "${mod}+l" = "exec --no-startup-id ${betterlockscreen} -l dim -t 'Please type your password'";
            "${mod}+Shift+F" = "floating enable, sticky enable";
            "${mod}+g" = "layout default";    # because we use i3-gaps, it's the gaps mode

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

            # Help: show all defined keybinds, in lexical order.
            "${mod}+F1" =
              let
                exec-keybind = pkgs.writeTextFile {
                  name = "fetch-i3-keybindings";
                  text =
                    let
                      awk-get-i3-keybinds =
                        "${awk} '$2 ~ /(${mod}(\+[^\+]+)+)|(XF86.+)/ { keybind=$2; $1=$2=\"\"; print keybind \":⁃\" $0 }' < ${config.xdg.configHome}/i3/config";
                      make-table =
                        "${column} -s':' -t";
                      rofi-show-keybinds =
                        "${rofi} -dmenu -p \"Defined keybindings\"";
                      awk-retrieve-keybind =
                        "${awk} '{ $1=$2=\"\"; print $0 }'";
                    in
                      ''
                        #!${pkgs.stdenv.shell}
                        ${i3-msg} $(${awk-get-i3-keybinds} | ${make-table} | ${rofi-show-keybinds} | ${awk-retrieve-keybind})
                      '';
                  executable = true;
                };
              in
                "exec --no-startup-id ${exec-keybind}";

            # Special keys
            "XF86MonBrightnessUp" = "exec --no-startup-id ${brightnessctl} s 5%+";
            "XF86MonBrightnessDown" = "exec --no-startup-id ${brightnessctl} s 5%-";
            "XF86AudioRaiseVolume" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ +4%";
            "XF86AudioLowerVolume" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ -4%";
            "XF86AudioMute" = "exec --no-startup-id ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86KbdBrightnessUp" = "exec --no-startup-id ${brightnessctl} --device=$(${brightnessctl-device}) s 1+";
            "XF86KbdBrightnessDown" = "exec --no-startup-id ${brightnessctl} --device=$(${brightnessctl-device}) s 1-";
          };

          bars = [ { mode = "invisible"; } ];
        };

        extraConfig =
          with builtins;
          readFile ./config;
      };
  };
}
