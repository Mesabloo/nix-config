{ config, lib, ... }:

{
  config = lib.mkIf config.modules.services.rofi.enable {
    home.file = {
      ".config/rofi/config".source = ./config;
      ".config/rofi/16script.rasi".source = ./16script.rasi;
    };
  };
}
