{ pkgs }:

{
  allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "input-fonts"
    "discord" 
    "teams"
    "unrar"
  ];
}
