{ config, options, lib, ... }:

with lib;
{
  config = mkIf config.modules.dev.git.enable {
    programs.git = {
      userName = "Mesabloo";
      userEmail = "22964017+Mesabloo@users.noreply.github.com";
    };
  };
}
