{ pkgs, lib, config, options, ... }:


with lib;
{
  options.modules.dev.kakoune = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.kakoune.enable {
    home.packages = with pkgs; [
      kakoune
    ];
  };
}
