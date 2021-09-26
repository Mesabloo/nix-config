self: super:

let
  unstable = import (builtins.fetchTarball {
    name = "nixpkgs-pinned";
    url = "https://github.com/nixos/nixpkgs/archive/3d85bb08106a3d32350df2786fda62aa7fd49cd8.tar.gz";
    # Use `nix-prefetch-url --unpack <url>`
    sha256 = "0g5yg292ixbv4lilc11fr754ym702a2h833am9hxi3ir5flwb3ah";
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
}
