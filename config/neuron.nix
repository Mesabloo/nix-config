{ config, pkgs, lib, options, ... }:

with lib;
{
  config = mkIf config.modules.services.neuron.enable {
    systemd.user.services.neuron =
      let
        notesDir = "${config.home.homeDirectory}/.zettel";
        port = "8336";
      in {
        Unit.Description = "Neuron zettelkasten service";
        Install.WantedBy = [ "graphical-session.target" ];
        Service = {
          ExecStart = ''${pkgs.neuron}/bin/neuron -d ${notesDir} rib -w -s:${port}'';
        };
      };
  };
}
