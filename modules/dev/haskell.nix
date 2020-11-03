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
    home.packages = with pkgs; [
      cachix

      cabal-install
      ghc
      stack
      # ^^^ See ./nix-overlays/unstable.nix

      # haskellPackages.hie
      haskell-language-server
    ];
  };
}
