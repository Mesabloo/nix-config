self: super:

let
  unstable = import (builtins.fetchTarball {
    name = "nixpkgs-pinned";
    url = "https://github.com/nixos/nixpkgs/archive/3c52ea8c9216a0d5b7a7b4d74a9d2e858b06df5c.tar.gz";
    # Use `nix-prefetch-url --unpack <url>`
    sha256 = "1sqg1rkkhcq4hg7gl2yrciv1w2b805mnxqnhlll3qvbs4lcw2x36";
  }) {};
in
{
  stack = unstable.stack;
  ghc = unstable.ghc;
  cabal-install = unstable.cabal-install;

  sd-switch = unstable.sd-switch;

  discord = unstable.discord;

  alacritty = unstable.alacritty;

  emacs = unstable.emacs;

  rofi = unstable.rofi;

  screenkey = unstable.screenkey;

  the-powder-toy = unstable.the-powder-toy;
  minecraft = unstable.minecraft;

  agda = unstable.agda;
  agda-pkg = unstable.agda-pkg;

  mercury = unstable.mercury;

  ocaml = unstable.ocaml;

  dunst = unstable.dunst;

  coq = unstable.coq;

  nerdfonts = unstable.nerdfonts;

#  glibc = unstable.glibc;
#  gcc = unstable.gcc;

  brave = unstable.brave;

  pentablet-driver = unstable.pentablet-driver;

  purescript = unstable.purescript;

  kakoune = unstable.kakoune;

  rust-analyzer = unstable.rust-analyzer;

  betterlockscreen = unstable.betterlockscreen;
}
