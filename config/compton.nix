{ lib, config, options, ... }:

with lib;
{
  config = mkIf config.modules.services.compton.enable {
    services.picom = {
      # Shadows
      shadow = true;



      # Fading
      fade = true;
      fadeDelta = 5;
      fadeSteps = [ "0.028" "0.03" ];

      backend = "xrender";
      # experimentalBackends = true;
      refreshRate = 75;

    };
  };
}
