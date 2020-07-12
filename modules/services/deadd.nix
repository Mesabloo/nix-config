# For now, it is a failed attempt at making
# https://github.com/phuhl/linux_notification_center work as a systemd service.

{ config, options, pkgs, lib, ... }:

with lib;
let
  mkTypeOption = type: default: description:
    mkOption { inherit type default description; };

  mkIntOption = mkTypeOption types.int;
  mkBoolOption = mkTypeOption types.bool;
  mkStrOption = mkTypeOption types.str;
in
{
  options.modules.services.deadd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    settings = {
      notification-center = {
        marginTop = mkIntOption 0 ''
                Margin at the top of the notification center in pixels. This can be
                used to avoid overlap between the notification center and bars such
                as polybars or i3blocks.'';
        marginBottom = mkIntOption 0 ''
                   Margin at the bottom of the notification center in pixels.'';
        marginRight = mkIntOption 0 ''
                  Margin to the right of the notification center in pixels'';
        width = mkIntOption 500 ''
            Width of the notification center in pixels.'';
        monitor = mkIntOption 0 ''
              Monitor on which the notification center will be printed.'';
        followMouse = mkBoolOption false ''
                  If true, the notification center will open on the screen, on which the
                  mouse is.'';

        startupCommand = mkOption {
          type = with types; nullOr str;
          default = null;
          description = ''
                    Command to run at startup. This can be used to setup
                    button states.'';
          example = ''
                startupCommand = "deadd-notification-center-startup";'';
        };
        newFirst = mkBoolOption true ''
               If newFirst is set to true, newest notifications appear on the top
               of the notification center. Else, notifications stack, from top to
       bottom.'';
        ignoreTransient = mkBoolOption false ''
                      If true, the transient field in notifications will be ignored and
                      the notification will be persisted in the notification center anyways'';
        useMarkup = mkBoolOption true ''
                If true, markup (<u>, <i>, <b>, <a>, <img>) will be displayed properly.'';
        configSendNotiClosedDbusMessage = mkBoolOption false ''
                                      If set to true, the parameter noClosedMsg can be set on
                                      notifications. If noClosedMsg is set to true on a notification,
                                      DBUS NotificationClosed messages will not be sent for this
                                      notification.'';
        guessIconFromAppName = mkBoolOption true ''
                           If set to true: If no icon is passed by the app_icon parameter
                           and no application "desktop-entry"-hint is present, the notification
                           center will try to guess the icon from the application name (if present).'';
      };

      notification-center-notification-popup = {
        notiDefaultTimeout = mkIntOption 10000 ''
                           Default timeout used for notifications in milli-seconds. This can
                           be overwritten with the "-t" option (or "--expire-time") of the
                           notify-send command.'';
        distanceTop = mkIntOption 50 ''
                    Margin above notifications (in pixels). This can be used to avoid
                    overlap between notifications and a bar such as polybar or i3blocks.'';
        distanceRight = mkIntOption 50 ''
                      Margin on the right of the notification (in pixels).'';
        distanceBetween = mkIntOption 20 ''
                        Vertical distance between 2 notifications (in pixels).'';
        width = mkIntOption 300 ''
              Width of the notifications.'';
        monitor = mkIntOption 0 ''
                Monitor on which the notifications will be printed.'';
        followMouse = mkBoolOption false ''
                    If true, the notifications will open on the screen, on which the
                    mouse is.'';
        iconSize = mkIntOption 20 ''
                 The display size of the application icons in the notification
                 pop-ups and in the notification center.'';
        maxImageSize = mkIntOption 100 ''
                     The maximal display size of images that are part of notifications
                     for notification pop-ups and in the notification center.'';
      };

      colors = {
        # Note about colors: Colors can be represented in (at least, I mean,
        # who knows...) three different ways:
        #   1. #RGD with "R", "G" and "B" hexadecimal numbers (0-9, A-F or
        #      a-f).
        #   2. #RRGGBB with each occurrence of "R", "G" and "B" are hexadecimal
        #      numbers (0-9, A-F, a-f).
        #   3. rgba(R, G, B, A) where "R", "G" and "B" are between 0 and 255
        #      and "A" is a floating point number between 0 and 1 representing
        #      the alpha channel (transparency).
        background = mkStrOption "rgba(29, 27, 20, 0.6)" ''
                   Background color for the notification center.'';
        notiBackground = mkStrOption "rgba(9, 0, 0, 0.5)" ''
                       Background color for the notification popups.'';
        notiColor = mkStrOption "#fef3f6" ''
                  Color for the text (summary, body and application name) in
                  notification popups.'';
        critical = mkStrOption "rgba(255, 0, 50, 0.5)" ''
                 Background color for "critical" notifications popups.'';
        criticalColor = mkStrOption "#FFF" ''
                      Color for the text (summary, body and application name) in
                      "critical" notification popups.'';
        criticalInCenter = mkStrOption "rgba(155, 0, 20, 0.5)" ''
                         Background color for "critical" notifications in notification center.'';
        criticalInCenterColor = mkStrOption "#FFF" ''
                              Color for the text (summary, body and application name) in
                              "critical" notification in notification center.'';
        labelColor = mkStrOption "#eae2e0" ''
                   Global text color.'';

        # These button configurations are applied globally (except they
        # get overwritten in the [buttons] section. The buttons section
        # only applies to the configurable buttons within the notification
        # center, while these configs also apply to the buttons within
        # notifications.)
        buttonColor = mkStrOption "#eae2e0" ''
                    Color for the text in the buttons.'';
        buttonHover = mkStrOption "rgba(0, 20, 20, 0.2)" ''
                    Background color of button in hover state (mouse over).'';
        buttonHoverColor = mkStrOption "#fee" ''
                         Text color of button in hover state (mouse over).'';
      };

      buttons = {
        # This section describes the configurable buttons within the
        # notification center and NOT the buttons that appear in the
        # notifications.

        # Note: If you want your buttons in the notification center to be
        #       squares you should verify that the following equality holds:
        #       [notification-center]::width
        #          == [buttons]::buttonsPerRow * [buttons]::buttonHeight
        #             + ([buttons]::buttonsPerRow + 1) * [buttons]::buttonmargin
        buttonsPerRow = mkIntOption 5 ''
                      Number of buttons that can be drawn on a row of the notification
                      center.'';
        buttonHeight = mkIntOption 60 ''
                     Height of buttons in the notification center (in pixels).'';
        buttonMargin = mkIntOption 2 ''
                     Horizontal and vertical margin between each button in the
                     notification center (in pixels).'';
        labels = mkOption {
          type = with types; nullOr str;
          default = null;
          description = ''
                      Labels written on the buttons in the notification center. Labels
                      should be written between quotes and separated by a colon.'';
          example = ''
                  labels = \'\'
                         "VPN":"Bluetooth":"Wifi":"Screensaver"
                  \'\';'';
        };
        commands = mkOption {
          type = with types; nullOr str;
          default = null;
          description = ''
                      Each label is represented as a clickable button in the notification
                      center. The commands variable below define the commands that should
                      be launched when the user clicks on the associated button. There
                      should be the same number of entries in `commands` and in `labels`.'';
          example = ''
                  commands = \'\'
                           "sudo vpnToggle":"bluetoothToggle":"wifiToggle":"screensaverToggle"
                  \'\';'';
        };
        buttonColor = mkStrOption "#fee" ''
                    Color of the labels of the custom buttons in the notification
                    center.'';
        buttonBackground = mkStrOption "rgba(255, 255, 255, 0.15)" ''
                         Color of the custom buttons' background in the notification center.'';
        buttonHover = mkStrOption "rgba(0, 20, 20, 0.2)" ''
                    Color of the custom buttons' background in the notification center
                    when hovered.'';
        buttonHoverColor = mkStrOption "#fee" ''
                         Color of the labels of the custom buttons in the notification center
                         when hovered.'';
        buttonTextSize = mkStrOption "12px" ''
                       Text size of the custom buttons in the notification center.'';
        buttonState1 = mkStrOption "rgba(255, 255, 255, 0.5)" ''
                     Color of the custom buttons' background in the notification center
                     when its state is set to true as described in the Section Usage.'';
        buttonState1Color = mkStrOption "#fff" ''
                          Color of the custom buttons' text in the notification center
                          when its state is set to true as described in the Section Usage.'';
        buttonState1Hover = mkStrOption "rgba(0, 20, 20, 0.4)" ''
                          Color of the custom buttons' background, hovering, in the
                          notification center when its state is set to true as described in
                          the Section Usage.'';
        buttonState1HoverColor = mkStrOption "#fee" ''
                               Color of the custom buttons' text, hovering, in the
                               notification center when its state is set to true as described in
                               the Section Usage.'';
        buttonState2 = mkStrOption "rgba(255, 255, 255, 0.3)" ''
                     Color of the custom buttons' background, in the notification center
                     when the button is clicked and not yet set to a new value via the
                     method as described in Section Usage.'';
        buttonState2Color = mkStrOption "#fff" ''
                          Color of the custom buttons' text, in the notification center
                          when the button is clicked and not yet set to a new values via the
                          method as described in Section Usage.'';
        buttonState2Hover = mkStrOption "rgba(0, 20, 20, 0.3)" ''
                          Color of the custom buttons' background,
                          hovering, in the notification center when the button is clicked and
                          not yet set to a new value via the method as described in Section
                          Usage.'';
        buttonState2HoverColor = mkStrOption "#fee" ''
                               Color of the custom buttons' text, hovering, in the notification
                               center when the button is clicked and not yet set to a new value via
                               the method as described in Section Usage.'';
      };
    };
  };

  config = mkIf config.modules.services.deadd.enable {
    home.packages = with pkgs; [
      deadd-notification-center
      libnotify
    ];

    xdg.dataFile."dbus-1/services/com.ph-uhl.deadd.notification.service".source =
      "${pkgs.deadd-notification-center}/share/dbus-1/services/com.ph-uhl.deadd.notification.service";

    systemd.user.services.deadd-notification-center = {
      Unit = {
        Description = "Deadd notification daemon";
        Require = [ "dbus.service" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.deadd-notification-center}/bin/deadd-notification-center";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };

    xdg.configFile."deadd/deadd.conf".text =
      let
        toINI = lib.generators.toINI {
          mkKeyValue = key: value:
            let
              val = if lib.isString value then
                      value
                    else if lib.isBool value then
                      (if value then "true" else "false")
                    else
                      toString value;
            in if value == null then
                 "# ${key}="
               else
                 "${key}=${val}";
        };
      in
        toINI config.modules.services.deadd.settings;
  };
}
