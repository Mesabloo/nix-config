{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.dev.coq = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.coq.enable {
    home.packages = with pkgs; [
      coq
    ];
  };
}
