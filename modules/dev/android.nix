{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.dev.android = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.android.enable {
    home.packages = with pkgs; [
      android-studio
      qemu_kvm
    ];

    nixpkgs.config.android_sdk.accept_license = true;

    modules.dev.java.enable = true;
  };
}
