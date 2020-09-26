{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.apps.teams = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.teams.enable {
    home.packages = with pkgs; [
      teams
    ];
  };
}
