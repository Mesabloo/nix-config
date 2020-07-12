# Heavy electron application for programming.

{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.dev.vscode = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.vscode.enable {
    home.packages = with pkgs; [
      vscode
    ];
  };
}
