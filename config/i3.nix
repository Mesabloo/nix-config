{ lib, config, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).config;

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
  i3-workspace-swap = "${pkgs.i3-workspace-swap}/bin/i3-workspace-swap";
  player-mpris-tail = "${pkgs.polybar-scripts.player-mpris-tail}/bin/player-mpris-tail";

  brightnessctl-device = "${brightnessctl} --list | ${grep} kbd | ${awk} '{print $2}' | ${sed} -e \"s/'//g\"";
in
with lib;
{
  config = mkIf config.modules.desktop.i3.enable {
    xsession.windowManager.i3 =
      let
        mod = "Mod4";

        workspaces = [
#          "10"
          "1: "
          "2: "
          "3: "
          "4: "
          "5: "
          "6: "
          "7: "
          "8: "
          "9: "
        ];
      in {
        config = {
          modifier = mod;

          fonts = [ "pango:FontAwesome 12" ];

          keybindings =
            let
              workspaceKeybinds = builtins.listToAttrs (flatten (imap0 (i: ws:
              let
                i' = builtins.toString (i + 1);
              in
                [ (nameValuePair "${mod}+${i'}" "workspace \"${ws}\"")
                  (nameValuePair "${mod}+Shift+${i'}" "move container to workspace \"${ws}\"")
                  (nameValuePair "${mod}+Control+${i'}" "exec --no-startup-id ${i3-workspace-swap} -d '${ws}' -f")
                ]
              ) workspaces));
            in
            mkOptionDefault (
              {
                "${mod}+Print" = "exec --no-startup-id ${flameshot} gui";
                "${mod}+Return" = "exec --no-startup-id ${env} WINIT_X11_SCALE_FACTOR=1 ${config.modules.services.shell.emulator}/bin/*";
                "${mod}+d" = "exec --no-startup-id ${rofi} -show drun";
                "${mod}+Tab" = "exec --no-startup-id ${rofi} -show window";
                "${mod}+Ctrl+Left" = "move workspace to output left";
                "${mod}+Ctrl+Right" = "move workspace to output right";
                "${mod}+l" = "exec --no-startup-id ${betterlockscreen} -l dim -t 'Please type your password'";
                "${mod}+Shift+F" = "floating enable, sticky enable";
                "${mod}+g" = "layout default";    # because we use i3-gaps, it's the gaps mode
                "${mod}+equal" = "move scratchpad";
                "${mod}+Shift+equal" = "scratchpad show";

                # Help: show all defined keybinds, in lexical order.
                "${mod}+F1" =
                  let
                    exec-keybind = pkgs.writeTextFile {
                      name = "fetch-i3-keybindings";
                      text =
                        let
                          awk-get-i3-keybinds = "${awk} '$2 ~ /(${mod}(\+[^\+]+)+)|(XF86.+)/ { keybind=$2; $1=$2=\"\"; print keybind \"@⁃\" $0 }' < ${config.xdg.configHome}/i3/config";
                          make-table = "${column} -s'@' -t";
                          rofi-show-keybinds = "${rofi} -dmenu -p \"Defined keybindings\"";
                          awk-retrieve-keybind = "${awk} '{ $1=$2=\"\"; print $0 }'";
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
                  "XF86AudioPrev" = "exec --no-startup-id ${player-mpris-tail} previous";
                  "XF86AudioNext" = "exec --no-startup-id ${player-mpris-tail} next";
                  "XF86AudioPlay" = "exec --no-startup-id ${player-mpris-tail} play-pause";
                  "XF86AudioStop" = "exec --no-startup-id ${player-mpris-tail} stop";
              } // workspaceKeybinds
            );

          bars = [ { mode = "invisible"; } ];

          assigns = builtins.listToAttrs [
            (nameValuePair "\"${elemAt workspaces 0}\"" [{ class = "discord"; } { title = "^(?!Microsoft Teams Notification).*$"; class = "Microsoft Teams - Preview"; }])
            (nameValuePair "\"${elemAt workspaces 1}\"" [{ class = "Emacs"; } { class = "jetbrains-idea-ce"; } { class = "jetbrains-studio"; } { class = "QtCreator"; }])
            (nameValuePair "\"${elemAt workspaces 2}\"" [{ class = "Brave-browser"; }])
            (nameValuePair "\"${elemAt workspaces 5}\"" [{ class = "vlc"; }])
            (nameValuePair "\"${elemAt workspaces 6}\"" [{ class = "Pulseeffects"; } { class = "Pavucontrol"; }])
          ];

          focus = {
            mouseWarping = false;
          };

          floating = {
            border = 0;
            criteria = [ { class = "floating"; } { title = "Microsoft Teams Notification"; } ];
          };

          gaps = {
            top = 40;
            bottom = 40;
            inner = 10;

            smartBorders = "on";
          };

          startup = [
            { command = "${pkgs.numlockx}/bin/numlockx on"; always = true; notification = false; }
            { command = "${pkgs.nitrogen}/bin/nitrogen --restore"; always = true; notification = false; }
            { command = "${pkgs.bash}/bin/bash ${config.xdg.configHome}/polybar/launch.sh"; always = true; notification = false; }
          ];

          window = {
            border = 0;
          };

          workspaceAutoBackAndForth = true;
        };

        extraConfig = ''
          no_focus [title="Microsoft Teams Notification"]
        '';
      };
  };
}
