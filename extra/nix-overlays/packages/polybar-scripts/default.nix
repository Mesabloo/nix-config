{ pkgs }:

{
  player-mpris-tail = pkgs.callPackage ./player-mpris-tail.nix { inherit pkgs; };
  system-uptime = pkgs.callPackage ./system-uptime.nix { inherit pkgs; };
}
