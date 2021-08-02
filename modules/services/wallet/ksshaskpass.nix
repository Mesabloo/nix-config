{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.services.wallet.ksshaskpass = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.wallet.ksshaskpass.enable {
    home.packages = with pkgs; [
      libsForQt5.ksshaskpass
      libsForQt5.kwallet
    ];
  };
}
