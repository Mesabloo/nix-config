{ config, options, pkgs, lib, ... }:

with lib;
{
  config = mkIf (config.modules.services.shell.emulator == pkgs.alacritty) {
    programs.alacritty.enable = true;

    xdg.configFile."alacritty/alacritty.yml".source =
      ./config.yml;

    programs.zsh.localVariables = mkIf config.modules.services.shell.zsh.enable {
      "WINIT_X11_SCALE_FACTOR" = 1;
    };
  };
}
