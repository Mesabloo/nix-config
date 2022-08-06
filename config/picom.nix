{ lib, config, options, ... }:

with lib;
{
  config = mkIf config.modules.services.picom.enable {
    services.picom = {
      # Shadows
      shadow = true;
      shadowOffsets = [ (-20) (-20) ];

      # Fading
      fade = true;
      fadeDelta = 4;
      fadeSteps = [ "0.028" "0.03" ];

      backend = "xrender";
      experimentalBackends = true;
      # refreshRate = 0;

      # Blur on rofi
      blur = config.modules.services.rofi.enable;
      blurExclude = [ "class_g != 'Rofi'" ];
      extraOptions = ''
        blur:
        {
          method = "dual_kawase";
          strength = 3;
        };
      '';
    };
  };
}
