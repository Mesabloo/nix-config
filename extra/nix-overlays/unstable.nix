self: super:

let
  nixos-unstable = import <nixos-unstable> {};
in
{
  stack = nixos-unstable.stack;
  ghc = nixos-unstable.ghc;
  cabal-install = nixos-unstable.cabal-install;

  sd-switch = nixos-unstable.sd-switch;
}
