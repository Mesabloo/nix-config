self: super:

let
  pkgs = super;
in
rec {
  deadd-notification-center = pkgs.callPackage ./deadd-notification-center.nix { inherit pkgs; };
  mount-helper = pkgs.callPackage ./mount-helper.nix { inherit pkgs; };
  polybar-scripts = pkgs.callPackage ./polybar-scripts { inherit pkgs; };
  unipicker = pkgs.callPackage ./unipicker.nix { inherit pkgs; };
  acc = pkgs.callPackage ./acc.nix { inherit pkgs; };
  nord-xresources = pkgs.callPackage ./nord-xresources.nix { inherit pkgs; };
  picom = pkgs.callPackage ./picom.nix { inherit pkgs; };
  python38Packages = super.python38Packages // {
    #    python-lsp-jsonrpc = pkgs.callPackage ./python-lsp-jsonrpc.nix { inherit pkgs; };
    python-lsp-server = pkgs.callPackage ./python-lsp-server.nix { inherit pkgs; };
  };
  # mdfmt = pkgs.callPackage ./mdfmt.nix { inherit pkgs; };
  jprofiler = pkgs.callPackage ./jprofiler.nix { inherit pkgs; };
  agda = pkgs.callPackage ./agda.nix (pkgs // {
    Agda = pkgs.haskellPackages.Agda;
    ghcWithPackages = pkgs.ghc.withPackages;
  });
  mdfmt = pkgs.callPackage ./mdfmt.nix { inherit pkgs; };
  input-fonts = pkgs.callPackage ./input-fonts.nix { };
  noise-suppression-for-voice = pkgs.callPackage ./noise-suppression-pipewire.nix { };
}

