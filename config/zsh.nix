{ lib, pkgs, config, options, ... }:

with lib;
let 
  sysconfig = (import <nixpkgs/nixos> {}).config;
in
{
  config = mkIf config.modules.services.shell.zsh.enable {
    programs.zsh = {
      enableAutosuggestions = true;
      enableCompletion = true;
      localVariables = {
        PATH = "$PATH:$HOME/.local/bin";
      } // (mkIf config.modules.dev.git.enable {
        GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      }) // (mkIf config.modules.dev.java.enable {
        JAVA_HOME = "${config.modules.dev.java.jdk}/lib/openjdk";
      });

      oh-my-zsh = mkIf config.modules.services.shell.zsh.oh-my-zsh.enable {
        theme = "ys";
        plugins = [ "git" "sudo" ];
      };

      shellAliases = mkIf sysconfig.virtualisation.docker.enable {
        "docker_run_oraclexe" = "${pkgs.docker}/bin/docker run -d -p 49161:1521 oracleinanutshell/oracle-xe-11g";
      };
    };
  };
}
