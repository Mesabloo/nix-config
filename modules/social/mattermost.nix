# Yeah... I need to socialise quite a lot.

{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.social.mattermost = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.social.mattermost.enable {
    home.packages = with pkgs; [
      mattermost-desktop
    ];
  };
}
