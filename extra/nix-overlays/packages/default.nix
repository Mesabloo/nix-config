self: super:

let
  pkgs = import <nixpkgs> {};
in
{
  deadd-notification-center = pkgs.callPackage ./deadd-notification-center.nix { inherit pkgs; };
  key-mon = pkgs.callPackage ./key-mon.nix { inherit pkgs; };
  neuron = pkgs.callPackage ./neuron.nix { inherit pkgs; };
  mount-helper = pkgs.callPackage ./mount-helper.nix { inherit pkgs; };
  polybar-scripts = pkgs.callPackage ./polybar-scripts { inherit pkgs; };
  haskell-language-server = pkgs.callPackage ./haskell-language-server.nix { inherit pkgs; };
  void-space = pkgs.callPackage ./void-space.nix { inherit pkgs; };
  i3-workspace-swap = pkgs.callPackage ./i3-workspace-swap.nix { inherit pkgs; };
  unipicker = pkgs.callPackage ./unipicker.nix { inherit pkgs; };
  acc = pkgs.callPackage ./acc.nix { inherit pkgs; };
  icomoon-feather = pkgs.callPackage ./icomoon-feather.nix { inherit pkgs; };
  nord-xresources = pkgs.callPackage ./nord-xresources.nix { inherit pkgs; };
  picom = pkgs.callPackage ./picom.nix { inherit pkgs; };
}
