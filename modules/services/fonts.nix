{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.services.fonts = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    iosevka = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };

    font_awesome = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };

    nerdfonts = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };

      fonts = mkOption {
        type = types.listOf types.str;
        default = [ ];
      };
    };

    mplus = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf config.modules.services.fonts.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      (mkIf config.modules.services.fonts.iosevka.enable iosevka)
      (mkIf config.modules.services.fonts.font_awesome.enable font-awesome)
      (mkIf config.modules.services.fonts.nerdfonts.enable (nerdfonts.override { fonts = config.modules.services.fonts.nerdfonts.fonts; }))
      (mkIf config.modules.services.fonts.mplus.enable mplus-outline-fonts.githubRelease)
    ];
  };
}
