{ pkgs, lib, config, ... }:

{
  programs.ssh.extraConfig = ''
    Host bitbucket.org
      AddKeysToAgent yes
      IdentityFile ${config.home.homeDirectory}/bitbucket_inria
  '';
}