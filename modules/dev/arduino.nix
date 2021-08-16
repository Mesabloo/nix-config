{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.dev.arduino = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.android.enable {
    home.packages = with pkgs; [
      arduino
    ];

    modules.dev.java.enable = true;
  };
}
