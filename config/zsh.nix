{ lib, pkgs, config, options, ... }:

with lib;
let 
  sysconfig = (import <nixpkgs/nixos> {}).config;
  home = config.home.homeDirectory;
in
{
  config = mkIf config.modules.services.shell.zsh.enable {
    programs.zsh = {
      enableAutosuggestions = true;
      enableCompletion = true;
      localVariables = {
        PATH = "$PATH:${home}/.local/bin";
      } // (mkIf config.modules.dev.git.enable {
        GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      }) // (mkIf config.modules.dev.ats2.enable {
        PATSHOME = "${config.modules.dev.ats2.package}";
      });

      oh-my-zsh = mkIf config.modules.services.shell.zsh.oh-my-zsh.enable {
        theme = "ys";
        plugins = [ "git" "sudo" ];
      };

      shellAliases = mkIf sysconfig.virtualisation.docker.enable {
        "docker_run_oraclexe" = "${pkgs.docker}/bin/docker run -d -p 49161:1521 oracleinanutshell/oracle-xe-11g";
      };

      initExtra = mkIf config.modules.dev.ocaml.enable ''
        test -r ${home}/.opam/opam-init/init.zsh && . ${home}/.opam/opam-init/init.zsh &> /dev/null || true
      '';
    };

    programs.command-not-found.enable = true;
  };
}
