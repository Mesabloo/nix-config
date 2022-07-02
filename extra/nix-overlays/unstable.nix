self: super:

let
  unstable = import
    (builtins.fetchTarball {
      name = "nixpkgs-pinned";
      url = "https://github.com/nixos/nixpkgs/archive/1712ecaa5118815292f57d6669c3c81d84d842b3.tar.gz";
      # Use `nix-prefetch-url --unpack <url>`
      sha256 = "0yb0v1zml6jwzbc8sknbml82mqf6000ad66v8z26jnxfc6dp1kk6";
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

  #  glibc = unstable.glibc;
  #  gcc = unstable.gcc;

  brave = unstable.brave;

  pentablet-driver = unstable.pentablet-driver;

  purescript = unstable.purescript;

  kakoune = unstable.kakoune;

  rust-analyzer = unstable.rust-analyzer;

  betterlockscreen = unstable.betterlockscreen;

  haskell-language-server = unstable.haskell-language-server;

  visualvm = unstable.visualvm;
}
