self: super:

let
  pkgs = import <nixpkgs> {};
in
{
  deadd-notification-center = pkgs.callPackage ./deadd-notification-center.nix { inherit pkgs; };
}
