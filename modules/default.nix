{ config, options, ... }:

{
  imports = [
    ./apps
    ./desktop
    ./dev
    ./games
    ./linux
    ./net
    ./services
    ./social
    ./windows
  ];

  options = {};
  config = {};
}
