self: super:

let
  pkgs = import <nixpkgs> {};
in
{
  deadd-notification-center = pkgs.callPackage ./deadd-notification-center.nix { inherit pkgs; };
  key-mon = pkgs.callPackage ./key-mon.nix { inherit pkgs; };
  neuron = pkgs.callPackage ./neuron.nix { inherit pkgs; };
  mount-helper = pkgs.callPackage ./mount-helper.nix { inherit pkgs; };
  polybar-scripts = pkgs.callPackages ./polybar-scripts { inherit pkgs; };
  haskell-language-server = pkgs.callPackages ./haskell-language-server.nix { inherit pkgs; };
  void-space = pkgs.callPackage ./void-space.nix { inherit pkgs; };
  i3-workspace-swap = pkgs.callPackage ./i3-workspace-swap.nix { inherit pkgs; };
}
