{
  nixpkgs.overlays = [
    (import ./packages)
    (import ./unstable.nix)
    (import ./haskell-ide-engine.nix null null)
    # Um what, without those `null`s it doesn't work...
    #
    # $ home-manager switch
    # error: value is a function while a set was expected
    # (use '--show-trace' to show detailed location information)
  ];
}
