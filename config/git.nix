{ config, options, lib, pkgs, ... }:

{
  config = {
    programs.git = {
      enable = true;
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