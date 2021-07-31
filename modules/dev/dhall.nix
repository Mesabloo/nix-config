{ pkgs, options, config, lib, ... }:

with lib;
{
  options.modules.dev.dhall = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.dhall.enable {
    home.packages = with pkgs; [
      dhall
      dhall-json
      dhall-lsp-server
    ];
  };
}
