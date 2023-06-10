{ pkgs, config, options, lib, ... }:

{
  # Run the screenlock after waking up
  systemd.user.services = {
    "lock-sessions-on-suspend" = {
      Unit = {
        Description = "Run a screenlock tool right after waking up";
        After = [ "suspend.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
        RemainAfterExit = "no";
        StandardOutput = "journal";
      };
      Install = {
        WantedBy = [ "suspend.target" ];
      };
    };
  };

  systemd.user.targets = {
    "suspend" = {
      Unit = {
        Description = "User level suspend target";
        StopWhenUnneeded = "yes";
        Wants = "lock-sessions-on-suspend.service";
      };
    };
  }; 
}