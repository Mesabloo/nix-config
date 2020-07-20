{ config, pkgs, lib, ... }:

with lib;
{
  config = mkIf config.modules.dev.agda.enable {
    home.packages = with pkgs; [
      AgdaStdlib
    ];

    home.file = {
      ".agda/defaults".text = ''

    '';

    ".agda/libraries".text = ''
      ${home.file.".agda/standard-library.agda-lib"}
    '';

    ".agda/standard-library.agda-lib".text = ''
      name: standard-library
      include: ${pkgs.AgdaStdlib}/share/agda
    '';

    };
  };
}
