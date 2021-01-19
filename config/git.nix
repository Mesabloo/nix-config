{ config, options, lib, pkgs, ... }:

with lib;
{
  config = mkIf config.modules.dev.git.enable {
    programs.git = {
      userName = "Mesabloo";
      userEmail = "22964017+Mesabloo@users.noreply.github.com";
      # delta.enable = true;

      extraConfig = {
        http = {
          "sslCAinfo" = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
        };
      };
    };
  };
}
