{ lib, config, options, ... }:

with lib;
{
  config = mkIf config.modules.services.picom.enable {
    services.picom = {
      extraArgs = [ "--experimental-backends" ];

      # Shadows
      shadow = true;
      shadowOffsets = [ (-20) (-20) ];

      # Fading
      fade = true;
      fadeDelta = 4;
      fadeSteps = [ 0.028 0.03 ];

      backend = "glx";
      # experimentalBackends = true;
      # refreshRate = 0;

      # Blur on rofi
      # blur = config.modules.services.rofi.enable;
      # blurExclude = [ "class_g != 'Rofi'" ];
      settings = mkIf config.modules.services.rofi.enable {
        blur = {
          method = "dual_kawase";
          strength = 3;
        };
        blur-exclude = [ "class_g != 'Rofi'" ];
      };
      # extraOptions = ''
      #   blur:
      #   {
      #     method = "dual_kawase";
      #     strength = 3;
      #   };
      # '';
    };
  };
}
