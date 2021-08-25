{ pkgs }:

{
	pulse-listener = pkgs.callPackage ./pulse-listener.nix { inherit pkgs; };
	brightness-listener = pkgs.callPackage ./brightness-listener.nix { inherit pkgs; };
}
