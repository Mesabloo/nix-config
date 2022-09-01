self: super:

let
  unstable = import
    (builtins.fetchTarball {
      name = "nixpkgs-pinned";
      url = "https://github.com/nixos/nixpkgs/archive/0e304ff0d9db453a4b230e9386418fd974d5804a.tar.gz";
      # Use `nix-prefetch-url --unpack <url>`
      sha256 = "0c91rbax0yh9xbg2l6qx9nfmisz4g6c36rlg8zjclfm3yqc8hkfl";
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

  agda = unstable.agda;
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
}
