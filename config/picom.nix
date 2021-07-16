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

      backend = "glx";
      experimentalBackends = true;
      refreshRate = 75;
    };
  };
}
