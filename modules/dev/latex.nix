{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.dev.latex = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.latex.enable {
    home.packages = with pkgs; [
      texlive.combined.scheme-full
    ];
  };
}
