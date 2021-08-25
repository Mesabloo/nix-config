{ pkgs, options, config, lib, ... }:

with lib;
{
  options.modules.dev.nix = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf config.modules.dev.nix.enable {
    home.packages = with pkgs; [
      rnix-lsp
      nixpkgs-fmt
    ];
  };
}
