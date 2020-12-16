{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.dev.web = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    php = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };

      package = mkOption {
        type = types.package;
        default = pkgs.php;
      };
    };
  };

  config = mkIf config.modules.dev.web.enable {
    home.packages = mkIf config.modules.dev.web.php.enable
      [
        config.modules.dev.web.php.package
        pkgs.php73Packages.composer
      ];
  };
}
