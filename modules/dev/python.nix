# I mostly use Python for quick scripting, nothing too serious.

{ pkgs, config, options, lib, ... }:

with lib;
{
  options.modules.dev.python = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.python.enable {
    home.packages = with pkgs; [
      python38
      python38Packages.pip   # Package installer
      yapf
      python38Packages.python-lsp-server
    ];
  };
}
