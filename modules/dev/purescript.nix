# I'm feeling lazy right now...

{ pkgs, options, config, lib, ... }:

with lib;
{
  options.modules.dev.purescript = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.purescript.enable {
    home.packages = with pkgs; [
      purescript
      spago

      nodejs
      nodePackages.npm
    ];

    modules.dev.dhall.enable = mkDefault true;
  };
}
