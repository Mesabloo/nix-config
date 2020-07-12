# Yeah, I like brave (not because I gives me money from ads).

{ pkgs, lib, options, config, ... }:

with lib;
{
  options.modules.net.brave = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    defaultBrowser = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.net.brave.enable {
    home.packages = with pkgs; [
      brave
    ];

    home.sessionVariables =
      if config.modules.net.brave.defaultBrowser
      then { BROWSER = "brave"; }
      else {};
  };
}
