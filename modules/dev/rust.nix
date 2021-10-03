# Who said low-level programming with guarantees was impossible?

{ pkgs, options, config, lib, ... }:

with lib;
{
  options.modules.dev.rust = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.rust.enable {
     home.packages =
       let
         cargo2nix = import (fetchTarball https://github.com/tenx-tech/cargo2nix/archive/master.tar.gz) {};
       in with pkgs; [
         rustup
         cargo2nix.package   # Converts `Cargo.toml` files into Nix expressions
         #cargo
         #rustc
         #rls
       ];
  };
}
