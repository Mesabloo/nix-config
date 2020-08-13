# Random linux utils that I want to have on my computer

{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.linux.utils = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.linux.utils.enable {
    home.packages = with pkgs; [
      bat          # `cat`, but actually better
      cloc         # count my lines of code
      dialog       # terminal dialog boxes
      hyperfine    # gotta go fast
      mount-helper # See the overlays. Makes it easy to mount a disk
      neofetch     # please tell me my system information
      texinfo      # if one day I want to write some documentation...
      wget         # `curl` is better
    ];
  };
}
