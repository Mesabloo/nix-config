{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.social.teams = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.social.teams.enable {
    home.packages = with pkgs; [
      teams
    ];
  };
}
