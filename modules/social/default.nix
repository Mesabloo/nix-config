{ config, options, ... }:

{
  imports = [
    ./discord.nix
    ./mattermost.nix
    ./teams.nix
  ];

  config = {};
  options = {};
}
