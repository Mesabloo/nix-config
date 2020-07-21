{ config, options, lib, pkgs, ... }:

with lib;
{
  config = mkIf (config.modules.services.shell.emulator == pkgs.termite) {
    programs.termite = {
      enable = true;

      # [options]
      allowBold = true;
      optionsExtra = ''
        bold_is_bright = true
      '';
      clickableUrl = true;
      font = "Monospace 9";
      scrollOnKeystroke = true;
      scrollbackLines = 10000;

      # [colors]
      highlightColor = "#2f2f2f";
      colorsExtra = ''
        color0 = #3f3f3f
        color1 = #705050
        color2 = #60b48a
        color3 = #dfaf8f
        color4 = #506070
        color5 = #dc8cc3
        color6 = #8cd0d3
        color7 = #dcdccc
        color8 = #709080
        color9 = #dca3a3
        color10 = #c3bf9f
        color11 = #f0dfaf
        color12 = #94bff3
        color13 = #ec93d3
        color14 = #93e0e3
        color15 = #ffffff
      '';

      # [hints]
      hintsPadding = 2;
    };
  };
}
