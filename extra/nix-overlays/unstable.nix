self: super:

let
  unstable = import
    (builtins.fetchTarball {
      name = "nixpkgs-pinned";
      url = "https://github.com/nixos/nixpkgs/archive/7b06206fa24198912cea58de690aa4943f238fbf.tar.gz";
      # Use `nix-prefetch-url --unpack <url>`
      sha256 = "0q53nmwj96gf9q0y6krbf7969w54ymni9wfrca25sqfdzjzk65bm";
    })
    { };
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

  # agda = unstable.agda;
  agda-pkg = unstable.agda-pkg;

  mercury = unstable.mercury;

  ocaml = unstable.ocaml;

  dunst = unstable.dunst;

  coq = unstable.coq;

  nerdfonts = unstable.nerdfonts;

  # glibc_multi = unstable.glibc_multi;
  # gcc = unstable.gcc;

  # cargo = unstable.cargo;
  # rustc = unstable.rustc;

  brave = unstable.brave;

  pentablet-driver = unstable.pentablet-driver;

  purescript = unstable.purescript;

  kakoune = unstable.kakoune;

  rust-analyzer = unstable.rust-analyzer;

  betterlockscreen = unstable.betterlockscreen;

  haskell-language-server = unstable.haskell-language-server;

  visualvm = unstable.visualvm;

  xmonad = unstable.xmonad;

  dotty = unstable.dotty;
}
