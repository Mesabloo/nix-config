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

    home.sessionVariables = {
      PATH = "${home}/.local/bin:$PATH";
    } // (if config.modules.dev.git.enable then {
      GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    } else {}) // (if config.modules.dev.ats2.enable then {
      PATSHOME = "${config.modules.dev.ats2.package}";
    } else {});
  };
}
