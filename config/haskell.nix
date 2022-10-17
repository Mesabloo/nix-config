{ config, options, lib, pkgs, ... }:

with lib;
{
  config = mkIf config.modules.dev.haskell.enable {
    home.file = {
      ".ghci".text = ''
        :set prompt "\ESC[1;34;1m%s\n\ESC[0;31;1mλ> \ESC[m"
        :set prompt-cont "\ESC[0;31;1mλ| \ESC[m"
        :set +m
      '';

      ".stack/config.yaml".text = ''
        nix:
          enable: true

        system-ghc: true

        recommend-stack-upgrade: false

        templates:
          params:
            author-name: Mesabloo
            github-username: mesabloo
      '';
    };
  };
}
