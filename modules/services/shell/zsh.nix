# Pimp my terminal

{ lib, pkgs, config, options, ... }:

with lib;
{
  options.modules.services.shell.zsh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    oh-my-zsh = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf config.modules.services.shell.zsh.enable {
    programs.zsh.enable = true;
    programs.zsh.oh-my-zsh.enable =
      mkIf config.modules.services.shell.zsh.oh-my-zsh.enable true;
  };
}
