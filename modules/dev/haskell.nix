# I'm feeling lazy right now...

{ pkgs, options, config, lib, ... }:

with lib;
{
  options.modules.dev.haskell = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.haskell.enable {
    home.packages =
      let
        stack2nix = import (builtins.fetchTarball https://github.com/input-output-hk/stack2nix/archive/master.tar.gz) {};
      in with pkgs; [
        cachix

        cabal-install
        ghc
        stack
        # ^^^ See ./nix-overlays/unstable.nix

        stack2nix
      ];
  };
}
