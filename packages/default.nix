self: super:

let
  pkgs = super;
in
rec {
  deadd-notification-center = pkgs.callPackage ./deadd-notification-center.nix { inherit pkgs; };
  key-mon = pkgs.callPackage ./key-mon.nix { inherit pkgs; };
  neuron = pkgs.callPackage ./neuron.nix { inherit pkgs; };
  mount-helper = pkgs.callPackage ./mount-helper.nix { inherit pkgs; };
  polybar-scripts = pkgs.callPackage ./polybar-scripts { inherit pkgs; };
  haskell-language-server = pkgs.callPackage ./haskell-language-server.nix { inherit pkgs; };
  void-space = pkgs.callPackage ./void-space.nix { inherit pkgs; };
  i3-workspace-swap = pkgs.callPackage ./i3-workspace-swap.nix { inherit pkgs; };
  unipicker = pkgs.callPackage ./unipicker.nix { inherit pkgs; };
  acc = pkgs.callPackage ./acc.nix { inherit pkgs; };
  icomoon-feather = pkgs.callPackage ./icomoon-feather.nix { inherit pkgs; };
  nord-xresources = pkgs.callPackage ./nord-xresources.nix { inherit pkgs; };
  picom = pkgs.callPackage ./picom.nix { inherit pkgs; };
  xob-scripts = pkgs.callPackage ./xob-scripts { inherit pkgs; };
  python38Packages = super.python38Packages // {
    #    python-lsp-jsonrpc = pkgs.callPackage ./python-lsp-jsonrpc.nix { inherit pkgs; };
    python-lsp-server = pkgs.callPackage ./python-lsp-server.nix { inherit pkgs; };
  };
  nbtexplorer = pkgs.callPackage ./nbtexplorer.nix { inherit pkgs; };
  # mdfmt = pkgs.callPackage ./mdfmt.nix { inherit pkgs; };
  jprofiler = pkgs.callPackage ./jprofiler.nix { inherit pkgs; };
  agda = pkgs.callPackage ./agda.nix (pkgs // {
    Agda = pkgs.haskellPackages.Agda;
    ghcWithPackages = pkgs.ghc.withPackages;
  });
  mdfmt = pkgs.callPackage ./mdfmt.nix { inherit pkgs; };
  polyml = pkgs.callPackage ./polyml.nix { };
  isabelle = pkgs.callPackage ./isabelle.nix { inherit polyml; };
  input-fonts = pkgs.callPackage ./input-fonts.nix { };
  noise-suppression-for-voice = pkgs.callPackage ./noise-suppression-pipewire.nix { };
  emacs-bis = pkgs.callPackage ./emacs.nix { };
  xboxdrv = pkgs.callPackage ./xboxdrv { };
}

