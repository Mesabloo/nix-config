# Emacs is life <3

{ pkgs, lib, config, options, ... }:


with lib;
{
  options.modules.dev.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.emacs.enable {
    home.packages = with pkgs; [
      emacs

      # Will try to setup doom emacs with Nix later.

      ispell
    ];
  };
}
