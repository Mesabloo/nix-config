{ pkgs, lib, options, config, ... }:

with lib;
{
  options.modules.services.unipicker = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.unipicker.enable {
    home.packages = with pkgs; [
      unipicker
      xclip
    ];
  };
}
