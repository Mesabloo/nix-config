{
  nixpkgs.overlays = [
    (import ./packages)
    (import ./unstable.nix)
  ];
}
