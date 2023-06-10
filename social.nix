{ config, options, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    teams
  ];
}