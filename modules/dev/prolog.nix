{ pkgs, options, config, lib, ... }:

with lib;
{
  options.modules.dev.prolog = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.prolog.enable {
    home.packages = with pkgs; [
      swiProlog
    ];
  };
}
