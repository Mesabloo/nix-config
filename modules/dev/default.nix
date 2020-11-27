{ config, options, ... }:

{
  imports = [
    ./agda.nix
    ./android.nix
    ./cpp.nix
    ./emacs.nix
    ./git.nix
    ./haskell.nix
    ./java.nix
    ./latex.nix
    ./mercury.nix
    ./prolog.nix
    ./python.nix
    ./rust.nix
    ./scala.nix
    ./vscode.nix
  ];

  config = {};
  options = {};
}
