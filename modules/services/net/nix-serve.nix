# I have two NixOS', so it's easier than downloading everything twice.

{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.services.net.nix-serve = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.net.nix-serve.enable {
    home.packages = with pkgs; [
      nix-serve
    ];
  };
}
