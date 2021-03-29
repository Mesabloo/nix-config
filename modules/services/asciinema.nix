{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.services.asciinema = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.asciinema.enable {
    home.packages = with pkgs; [
      asciinema
    ];
  };
}
