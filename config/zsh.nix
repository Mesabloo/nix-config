{ lib, pkgs, config, options, ... }:

with lib;
let
  sysconfig = (import <nixpkgs/nixos> { }).config;
  home = config.home.homeDirectory;
  headline-theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/moarram/headline/c12368adfbbaa35e7f21e743d34b59f8db263a95/headline.zsh-theme";
    sha256 = "sha256-maLgsPgfBbOKF8aW61CGzYRLE04Cxe1KfcDImocnaXA=";
  };
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

      plugins = [
        {
          name = "shrink-path";
          file = "plugins/shrink-path/shrink-path.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "ohmyzsh";
            repo = "ohmyzsh";
            rev = "1bda62dffadf175091fe144cb423db348e3029df";
            sha256 = "sha256-CKPTHP98ILzHGFxXyycYhXtpuW2tmb4zWwZgy98pN8A=";
          };
        }
      ];

      shellAliases = mkIf sysconfig.virtualisation.docker.enable {
        "docker_run_oraclexe" = "${pkgs.docker}/bin/docker run -d -p 49161:1521 oracleinanutshell/oracle-xe-11g";
      };

      initExtra =
        (if config.modules.dev.ocaml.enable then ''
          test -r ${home}/.opam/opam-init/init.zsh && . ${home}/.opam/opam-init/init.zsh &> /dev/null || true
        '' else "") + (if !config.modules.services.shell.zsh.oh-my-zsh.enable then ''
          setopt prompt_subst
          source ${headline-theme}

          HEADLINE_LINE_MODE=off

          HEADLINE_PROMPT="→ "

          HEADLINE_DO_ERR="true"
          HEADLINE_DO_ERR_INFO="true"

          HEADLINE_TRUNC_PREFIX="…"

          HEADLINE_GIT_STATUS_CMD=' '
          HEADLINE_PATH_CMD='shrink_path -f'

          HEADLINE_USER_PREFIX=" "
          HEADLINE_HOST_PREFIX=" "
          HEADLINE_PATH_PREFIX=" "
          HEADLINE_BRANCH_PREFIX=" "
          HEADLINE_USER_TO_HOST=" at "
          HEADLINE_HOST_TO_PATH=" in "
          HEADLINE_PATH_TO_BRANCH=" on "
          HEADLINE_PAD_TO_BRANCH=" on "
          HEADLINE_BRANCH_TO_STATUS=" ("
          HEADLINE_STATUS_TO_STATUS=" "
          HEADLINE_STATUS_END=")"
        '' else "");
    };

    programs.command-not-found.enable = true;

    home.sessionVariables = {
      PATH = "${home}/.local/bin:$PATH";
    } // (if config.modules.dev.git.enable then {
      GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    } else { }) // (if config.modules.dev.ats2.enable then {
      PATSHOME = "${config.modules.dev.ats2.package}";
    } else { });
  };
}

