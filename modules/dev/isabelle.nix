{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.dev.isabelle = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.isabelle.enable {
    home.packages = with pkgs; [
      isabelle
    ];

    home.sessionVariables = {
      "ISABELLE_HOME" = "${pkgs.isabelle}/Isabelle${pkgs.isabelle.version}";
    };
  };
}
