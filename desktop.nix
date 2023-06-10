{ lib, config, options, pkgs, unstable, ... }:

with lib;
{
  # We use XMonad around here.
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = ps: with ps; [
      containers
      xdg-basedir
      regex-tdfa
      directory
      filepath
    ];
    config = ./config/XMonad.hs;
    haskellPackages = pkgs.haskell.packages.ghc924;
  };

  fonts.fontconfig.enable = true;

  services.xidlehook = {
    enable = true;
    detect-sleep = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    timers = [
      {
        # 5 minutes: launch screen lock
        delay = 300;
        command = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
      }
      {
        # 15 minutes: turn screen(s) off
        delay = 900;
        command = "${pkgs.xorg.xset}/bin/xset dpms force off";
      }
      {
        # 1 hour: suspend the system
        delay = 3600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  xsession = {
    enable = true;
    initExtra = ''
      setxkbmap fr
      setxkbmap -option compose:rctrl

      ${pkgs.ibus}/bin/ibus-daemon -drxR
    '';
    numlock.enable = true;
  };

  home = {
    file.".XCompose".source = ./config/XCompose;
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 30;
      x11 = {
        defaultCursor = "default";
        enable = true;
      };
    };
  };

  xresources.extraConfig = ''
    #include "${pkgs.nord-xresources}/share/nord"
  '';

  # This service seems to disable the compose key and changes the default layout.
  # I don't want that.
  systemd.user.services.setxkbmap = {
    Service.ExecStart = lib.mkForce "${pkgs.coreutils}/bin/true";
  };

  # Dunst for notifications
  services.dunst = {
    enable = true;
    settings = import ./config/dunst-settings.nix { inherit pkgs; };
  };

  # Rofi for launching apps
  programs.rofi = {
    enable = true;
    theme = import ./config/rofi-theme.nix { inherit config; };
  };

  # Alacritty
  programs.alacritty = {
    enable = true;
    package = unstable.alacritty;
    settings = import ./config/alacritty-settings.nix;
  };

  # Polybar
  services.polybar = rec {
    enable = true;
    package = unstable.polybar.override {
      pulseSupport = true;
      alsaSupport = true;
    };
    script =
      let
        ip = "${pkgs.iproute}/bin/ip";
        grep = "${pkgs.gnugrep}/bin/grep";
        awk = "${pkgs.gawk}/bin/awk";
        head = "${pkgs.coreutils}/bin/head";
        xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
        cut = "${pkgs.coreutils}/bin/cut";
        sort = "${pkgs.coreutils}/bin/sort";
        true_ = "${pkgs.coreutils}/bin/true";
      in
      ''
      # Terminate already running bar instances
      echo "polybar> killing all running instances:"
      for POLYBAR in $(ls -A ${package}/bin); do
        ${pkgs.killall}/bin/killall $POLYBAR -w 2>/dev/null || ${true_}
      done

      WIFI=$(${ip} link | ${grep} --color=never UP | ${awk} -F'( |:)' '$3 ~ /wl.*/ {print $3}' | ${head} -1)
      ETHE=$(${ip} link | ${grep} --color=never UP | ${awk} -F'( |:)' '$3 ~ /enp.*/ {print $3}' | ${head} -1)

      SCREENS=($(${xrandr} --query | ${grep} ' connected' | ${cut} -d' ' -f1 | ${sort}))
      SCREEN_COUNT=''${#SCREENS[@]}

      echo "polybar> $SCREEN_COUNT monitor(s) found!"

      case $SCREEN_COUNT in
        1)
          polybar wminfo &
          WIFI_IF="$WIFI" ETHER_IF="$ETHE" polybar systeminfo-bottom &
        ;;
        *)
          # Let's assume that the screen numbers represent their order from left to right
          SCREEN_0=''${SCREENS[0]}
          SCREEN_N=''${SCREENS[-1]}

          MONITOR=$SCREEN_0 polybar wminfo &
          WIFI_IF="$WIFI" ETHER_IF="$ETHE" MONITOR=$SCREEN_N polybar systeminfo-top &
        ;;
      esac
      '';
    config = import ./config/polybar-config.nix { inherit pkgs; };
  };

  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "polybar" = "${pkgs.systemd}/bin/systemctl restart --user polybar";
        "nitrogen" = "${pkgs.nitrogen}/bin/nitrogen --restore";
      };
    };
  };

  # GTK style
  gtk = {
    enable = true;

    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };

    gtk3.extraConfig = {
      gtk-cursor-theme-name = "capitaine-cursors";
      gtk-cursor-theme-size = 30;
      gtk-application-prefer-dark-theme = true;
    };

    gtk2.extraConfig = ''
      gtk-cursor-theme-name=capitaine-cursors
      gtk-cursor-theme-size=30
      gtk-application-prefer-dark-theme=true
      gtk-theme-name="Nordic"
    '';

    iconTheme = {
      package = pkgs.libsForQt5.breeze-icons; # for the Nordic theme
      name = "breeze-dark";
    };

    font = {
      package = null;
      name = "Sans Serif Regular 10";
    };
  };

  # Qt
  qt = {
    enable = true;

    platformTheme = "gtk";

    style = {
      package = pkgs.nordic;
      name = "Nordic";
    };
  };

  services.picom = {
    enable = true;
    extraArgs = [ "--experimental-backends" ];

    # Shadows
    shadow = true;
    shadowOffsets = [ (-20) (-20) ];

    # Fading
    fade = true;
    fadeDelta = 4;
    fadeSteps = [ 0.028 0.03 ];

    backend = "glx";
    # experimentalBackends = true;
    # refreshRate = 0;

    # Blur on rofi
    # blur = config.modules.services.rofi.enable;
    # blurExclude = [ "class_g != 'Rofi'" ];
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 3;
      };
      blur-exclude = [ "class_g != 'Rofi'" ];
    };
    # extraOptions = ''
    #   blur:
    #   {
    #     method = "dual_kawase";
    #     strength = 3;
    #   };
    # '';
  };

  services.batsignal = {
    enable = true;
  };

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    }; 
  };

  home.file.".unipickerrc".text = ''
    # Command to use for selecting (e.g. fzf, rofi)
    UNIPICKER_SELECT_COMMAND="${pkgs.rofi}/bin/rofi -dmenu -p '' -theme sidebar"

    # Command to use for copying to clipboard (e.g. pbcopy)
    #UNIPICKER_COPY_COMMAND=

    # Where to load symbols file from
    UNIPICKER_SYMBOLS_FILE="${pkgs.unipicker}/share/unipicker/symbols"
  '';





  home.packages = with pkgs; [
    # For XMonad
    betterlockscreen
    nitrogen
    brightnessctl
    pulseaudio

    # For Rofi
    papirus-icon-theme
    fantasque-sans-mono

    # For alacritty
    input-fonts

    # For polybar
    xcbutilxrm
    font-awesome_5
    (nerdfonts.override {
      fonts = [ "Iosevka" "MPlus" ];
    })
    mplus-outline-fonts.githubRelease
    iproute
    xorg.xrandr

    # GTK
    capitaine-cursors
    gtk_engines
    gnome3.gnome-themes-extra

    # Qt
    libsForQt5.qtstyleplugins 

    arandr
    xorg.xev
    xorg.xfd

    # For unipicker
    unipicker
    xclip
  ];
}

