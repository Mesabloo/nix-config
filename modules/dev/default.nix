{ config, options, ... }:

{
  imports = [
    ./cpp.nix
    ./emacs.nix
    ./git.nix
    ./haskell.nix
    ./java.nix
    ./python.nix
    ./rust.nix
    ./vscode.nix
  ];

  config = {};
  options = {};
}
