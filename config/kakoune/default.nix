{ pkgs, config, options, lib, ... }:

with lib;
{
  config = mkIf config.modules.dev.kakoune.enable {
    xdg.configFile =
      let
        files = builtins.readDir (sourceByRegex ./. ["^.*\\.(toml|kak)$" "^kakrc$"]).outPath;
        allFiles = mapAttrs' (name: _: nameValuePair ("kak/" + name) { text = readFile "${./.}/${name}"; }) files;
      in
        allFiles
        // { "kak-lsp/kak-lsp.toml".source = ./kak-lsp/kak-lsp.toml; }
        // { "kak/modules".source = ./modules; };

    home.packages = with pkgs; [
      starship

#      kak-lsp
    ] ++ (if config.modules.dev.coq.enable then [ libxml2 ] else []);

    modules.dev.cpp.enable = true;
    modules.dev.rust.enable = true;
  };
}
