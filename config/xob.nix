{ pkgs, options, config, lib, ... }:

with lib;
{
  config = mkIf config.modules.services.xob.enable {
    home.packages = with pkgs; [
      xob-scripts.brightness-listener
      xob-scripts.pulse-listener
    ];

#		xsession.initExtra = with pkgs; ''
#		  (${xob-scripts.brightness-listener}/bin/brightness-listener | ${xob}/bin/xob -s brightness) 1> /dev/null &
#		  (${xob-scripts.pulse-listener}/bin/pulse-listener | ${xob}/bin/xob -s default) 1> /dev/null &
#		'';

		modules.services.xob.styles =
      let
        default = {
          thickness = 15;
          outline = 0;
          border = 2;
          padding = 0;

          color = {
            normal = {
              bg = "#2E3440";
              fg = "#ECEFF4";
              border = "#ECEFF4";
            };
            alt = {
              bg = "#2E3440";
              fg = "#4C566A";
              border = "#4C566A";
            };
            overflow = {
              bg = "#2E3440";
              fg = "#BF616A";
              border = "#BF616A";
            };
            altoverflow = {
              bg = "#2E3440";
              fg = "#B48EAD";
              border = "#B48EAD";
            };
          };
        };

        brightness = default // {
          x = { relative = 0; offset = 48; };
        };

      in { inherit default brightness; };
  };
}
