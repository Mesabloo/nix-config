{ config, options, pkgs, lib, ... }:

with lib;
{
  options.modules.dev.ats2 = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    package = mkOption {
      type = types.package;
      default = pkgs.ats2;
    };
  };

  config = mkIf config.modules.dev.ats2.enable {
    home.packages = with pkgs; [
      config.modules.dev.ats2.package
      pkgs.acc
      #haskellPackages.ats-pkg
    ];
  };
}
