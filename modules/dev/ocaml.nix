{ config, options, pkgs, lib, ... }:

with lib;
{
  options.modules.dev.ocaml = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.ocaml.enable {
    home.packages = with pkgs; [
      ocaml
      opam
    ];
  };
}
