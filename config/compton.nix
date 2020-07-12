{ lib, config, options, ... }:

with lib;
{
  config = mkIf config.modules.services.compton.enable {
    services.picom.shadow = true;
  };
}
