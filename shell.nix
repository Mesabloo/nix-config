{ config, options, lib, pkgs, ... }:

let
  headline-theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/moarram/headline/c12368adfbbaa35e7f21e743d34b59f8db263a95/headline.zsh-theme";
    sha256 = "sha256-maLgsPgfBbOKF8aW61CGzYRLE04Cxe1KfcDImocnaXA=";
  };
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true; 

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

    initExtra = ''
      autoload zkbd 
      [[ ! -f ''${ZDOTDIR:-$HOME}/.zkbd/$TERM-''${DISPLAY:-$VENDOR-$OSTYPE} ]] && zkbd
      source ''${ZDOTDIR:-$HOME}/.zkbd/$TERM-''${DISPLAY:-$VENDOR-$OSTYPE}

      [[ -n ''${key[Backspace]} ]] && bindkey "''${key[Backspace]}" backward-delete-char
      [[ -n ''${key[Insert]} ]] && bindkey "''${key[Insert]}" overwrite-mode
      [[ -n ''${key[Home]} ]] && bindkey "''${key[Home]}" beginning-of-line
      [[ -n ''${key[PageUp]} ]] && bindkey "''${key[PageUp]}" up-line-or-history
      [[ -n ''${key[Delete]} ]] && bindkey "''${key[Delete]}" delete-char
      [[ -n ''${key[End]} ]] && bindkey "''${key[End]}" end-of-line
      [[ -n ''${key[PageDown]} ]] && bindkey "''${key[PageDown]}" down-line-or-history
      [[ -n ''${key[Up]} ]] && bindkey "''${key[Up]}" up-line-or-search
      [[ -n ''${key[Left]} ]] && bindkey "''${key[Left]}" backward-char
      [[ -n ''${key[Down]} ]] && bindkey "''${key[Down]}" down-line-or-search
      [[ -n ''${key[Right]} ]] && bindkey "''${key[Right]}" forward-char



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
      HEADLINE_HOST_PREFIX="󰇅 "
      HEADLINE_PATH_PREFIX="󰉋 "
      HEADLINE_BRANCH_PREFIX=" "
      HEADLINE_USER_TO_HOST=" at "
      HEADLINE_HOST_TO_PATH=" in "
      HEADLINE_PATH_TO_BRANCH=" on "
      HEADLINE_PAD_TO_BRANCH=" on "
      HEADLINE_BRANCH_TO_STATUS=" ("
      HEADLINE_STATUS_TO_STATUS=" "
      HEADLINE_STATUS_END=")"
    '';
  };

  programs.command-not-found.enable = true;

  home.sessionVariables."PATH" = "${config.home.homeDirectory}/.local/bin:$PATH";
}