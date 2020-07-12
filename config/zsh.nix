{ lib, pkgs, config, options, ... }:

with lib;
{
  config = mkIf config.modules.services.shell.zsh.enable {
    programs.zsh = {
      enableAutosuggestions = true;
      enableCompletion = true;
      localVariables = {
        PATH = "$PATH:$HOME/.local/bin";
      } // (mkIf config.modules.dev.git.enable {
        GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      }) // (mkIf config.modules.dev.java.enable {
        JAVA_HOME = "${config.modules.dev.java.jdk}/lib/openjdk";
      });

      oh-my-zsh = mkIf config.modules.services.shell.zsh.oh-my-zsh.enable {
        theme = "ys";
        plugins = [ "git" "sudo" ];
      };
    };
  };
}
