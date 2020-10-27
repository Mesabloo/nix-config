{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.services.oracle-xe = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    port = mkOption {
      type = types.int;
      default = 3306;
    };
  };

  config = mkIf config.modules.services.oracle-xe.enable {
    home.packages = with pkgs; [
#      oracleXE # too old...
#      sqldeveloper
      oracle-instantclient
      dbeaver
    ];
  };
}
