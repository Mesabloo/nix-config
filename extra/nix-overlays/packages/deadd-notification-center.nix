{ pkgs
, stdenv ? pkgs.stdenv
, lib ? pkgs.lib
}:

let
  debug-prefix = ''${pkgs.coreutils}/bin/env PATH="${pkgs.glibc}/bin:$PATH" '';

  center = stdenv.mkDerivation rec {
    name = "deadd-notification-center";
    version = "1.7.2";

    srcs = [
      (pkgs.fetchurl {
        url = "https://github.com/phuhl/linux_notification_center/releases/download/${version}/deadd-notification-center";
        sha256 = "13f15slkjiw2n5dnqj13dprhqm3nf1k11jqaqda379yhgygyp9zm";
      })
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/ahmubashshir/linux_notification_center/master/com.ph-uhl.deadd.notification.service.in";
        sha256 = "10fiihiq4hzm0c8f432vpbn24hgr5fk3mg9f23q65bcs6ayx3sld";
      })
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/ahmubashshir/linux_notification_center/master/deadd-notification-center.service.in";
        sha256 = "09g7a4fxg75kbni9nbf3ldnkyvl5dy4y8xf9ar9p555zb5i1b54n";
      })
      (pkgs.fetchurl {
        url = "https://github.com/phuhl/linux_notification_center/blob/${version}/translation/en/LC_MESSAGES/deadd-notification-center.mo?raw=true";
        sha256 = "0sr536f4bgxd46f2m0dnj8kz7ryf7vxa49ddaidfdc24yr72514f";
      })
      (pkgs.fetchurl {
        url = "https://github.com/phuhl/linux_notification_center/blob/${version}/translation/de/LC_MESSAGES/deadd-notification-center.mo?raw=true";
        sha256 = "0rs8vkjd2l5il61kq0ix0vnhajc2biix8vxakz8h6rdhwrcr35if";
      })
    ];

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook

      gnumake
      dbus
      systemd

      pkg-config
    ];

    buildInputs = with pkgs; [
      libxml2
      gtk3
      pango
      cairo
      gobject-introspection
      zlib
    ];

    unpackPhase = ":";

    installPhase =
      with lib;
      let
        executable      = elemAt srcs 0;
        dbus-service    = elemAt srcs 1;
        systemd-service = elemAt srcs 2;
        translation-en  = elemAt srcs 3;
        translation-de  = elemAt srcs 4;
      in
      ''
        mkdir -p $out/bin

        echo "Installing executable"
        install -m755 ${executable} $out/bin/deadd-notification-center

        echo "Patching DBus service"
        sed "s|##PREFIX##|${debug-prefix} $out|" ${dbus-service} > $out/com.ph-uhl.deadd.notification.service
        mkdir -p $out/share/dbus-1/services
        echo "Installing DBus service"
        install -m644 $out/com.ph-uhl.deadd.notification.service $out/share/dbus-1/services
        rm $out/com.ph-uhl.deadd.notification.service

        echo "Patching systemd service"
        sed "s|##PREFIX##|${debug-prefix} $out|" ${systemd-service} > $out/deadd-notification-center.service
        mkdir -p $out/share/systemd/services
        echo "Installing systemd service"
        install -m644 $out/deadd-notification-center.service $out/share/systemd/services
        rm $out/deadd-notification-center.service

        echo "Installing translations"
        mkdir -p $out/share/locale/en/LC_MESSAGES
        mkdir -p $out/share/locale/de/LC_MESSAGES
        install -m644 ${translation-en} $out/share/locale/en/LC_MESSAGES/deadd-notification-center.mo
        install -m644 ${translation-de} $out/share/locale/de/LC_MESSAGES/deadd-notification-center.mo
      '';

    meta = with lib; {
      homepage = https://github.com/phuhl/linux_notification_center;
      description = "A haskell-written notification center for users that like a desktop with style…";
      platforms = platforms.all;
      maintainers = with maintainers; [ ph-uhl ];
    };
  };


  /*
  center = stdenv.mkDerivation rec {
    name = "deadd-notification-center";
    version = "1.7.2";

    srcs = [
      (pkgs.fetchurl {
        url = "https://github.com/phuhl/linux_notification_center/releases/download/${version}/deadd-notification-center";
        sha256 = "13f15slkjiw2n5dnqj13dprhqm3nf1k11jqaqda379yhgygyp9zm";
      })
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/ahmubashshir/linux_notification_center/master/com.ph-uhl.deadd.notification.service.in";
        sha256 = "10fiihiq4hzm0c8f432vpbn24hgr5fk3mg9f23q65bcs6ayx3sld";
      })
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/ahmubashshir/linux_notification_center/master/deadd-notification-center.service.in";
        sha256 = "09g7a4fxg75kbni9nbf3ldnkyvl5dy4y8xf9ar9p555zb5i1b54n";
      })
    ];

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook

      gnumake
      dbus
      systemd
    ];

    buildInputs = with pkgs; [
      gtk3
      gobject-introspection
      libxml2
      zlib
      pango
      cairo
      pkg-config
      zlib
    ];

    unpackPhase = ":";

    installPhase =
      with lib;
      let
        executable      = elemAt srcs 0;
        dbus-service    = elemAt srcs 1;
        systemd-service = elemAt srcs 2;
      in
      ''
        mkdir -p $out/bin

        echo "Installing executable"
        install -m755 ${executable} $out/bin/deadd-notification-center

        echo "Patching DBus service"
        sed "s|##PREFIX##|${debug-prefix} $out|" ${dbus-service} > $out/com.ph-uhl.deadd.notification.service
        mkdir -p $out/share/dbus-1/services
        echo "Installing DBus service"
        install -m644 $out/com.ph-uhl.deadd.notification.service $out/share/dbus-1/services

        echo "Patching systemd service"
        sed "s|##PREFIX##|${debug-prefix} $out|" ${systemd-service} > $out/deadd-notification-center.service
        mkdir -p $out/share/systemd/services
        echo "Installing systemd service"
        install -m644 $out/deadd-notification-center.service $out/share/systemd/services
      '';

    meta = with lib; {
      homepage = https://github.com/phuhl/linux_notification_center;
      description = "A haskell-written notification center for users that like a desktop with style…";
      platforms = platforms.all;
      maintainers = with maintainers; [ ph-uhl ];
    };
  }; */

  wrapped = pkgs.writeScriptBin "deadd-notification-center" ''
    #!${stdenv.shell}
    ${debug-prefix} ${center}/bin/deadd-notification-center
  '';
in
center
/* pkgs.symlinkJoin {
  name = "deadd-notification-center";
  paths = [ wrapped center ];
}
 */
