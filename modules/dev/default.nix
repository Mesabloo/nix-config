{ config, options, ... }:

{
  imports = [
    ./agda.nix
    ./android.nix
    ./arduino.nix
    ./ats2.nix
    ./coq.nix
    ./cpp.nix
    ./dhall.nix
    ./emacs.nix
    ./git.nix
    ./haskell.nix
    ./java.nix
    ./kakoune.nix
    ./latex.nix
    ./mercury.nix
    ./ocaml.nix
    ./prolog.nix
    ./purescript.nix
    ./python.nix
    ./rust.nix
    ./scala.nix
    ./vscode.nix
    ./web.nix
  ];

  config = {};
  options = {};
}
