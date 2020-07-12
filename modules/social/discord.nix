# Yeah... I need to socialise quite a lot.

{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.social.discord = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.social.discord.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
