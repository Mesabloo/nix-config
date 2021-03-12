{ config, options, ... }:

{
  imports = [
    ./agda.nix
    ./android.nix
    ./coq.nix
    ./cpp.nix
    ./emacs.nix
    ./git.nix
    ./haskell.nix
    ./java.nix
    ./latex.nix
    ./mercury.nix
    ./ocaml.nix
    ./prolog.nix
    ./python.nix
    ./rust.nix
    ./scala.nix
    ./vscode.nix
    ./web.nix
  ];

  config = {};
  options = {};
}
