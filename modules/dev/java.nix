# I feel ashamed of putting this in this config, but I don't have a choice...

{ pkgs, lib, options, config, ... }:

with lib;
{
  options.modules.dev.java = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    jdk = mkOption {
      type = types.package;
      default = pkgs.jdk11;
    };
  };

  config = mkIf config.modules.dev.java.enable {
    home.packages = with pkgs; [
      config.modules.dev.java.jdk
      jetbrains.idea-community  # Java IDE, because you can't program otherwise
    ];
  };
}
