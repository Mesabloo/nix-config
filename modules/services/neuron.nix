{ config, options, lib, pkgs, ... }:

with lib;
{
  options.modules.services.neuron = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.neuron.enable {
    home.packages = with pkgs; [ neuron ];
  };
}
