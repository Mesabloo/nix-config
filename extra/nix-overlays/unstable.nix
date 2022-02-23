self: super:

let
  unstable = import (builtins.fetchTarball {
    name = "nixpkgs-pinned";
    url = "https://github.com/nixos/nixpkgs/archive/38346f64616c3176f73ad0f20e51557ec0f3d75d.tar.gz";
    # Use `nix-prefetch-url --unpack <url>`
    sha256 = "0kxs5z821hl23v3vp2sjdx9m2hk43448nzi3nsfc1wmqlflv1rsr";
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
