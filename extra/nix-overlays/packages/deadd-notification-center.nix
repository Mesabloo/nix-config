{ pkgs
, stdenv ? pkgs.stdenv
, lib ? pkgs.lib
}:

stdenv.mkDerivation rec {
  name = "deadd-notification-center";
  version = "1.7.2";

  srcs = [
    (pkgs.fetchurl {
      url = "https://github.com/phuhl/linux_notification_center/releases/download/${version}/deadd-notification-center";
      sha256 = "13f15slkjiw2n5dnqj13dprhqm3nf1k11jqaqda379yhgygyp9zm";
    })
    (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/phuhl/linux_notification_center/${version}/com.ph-uhl.deadd.notification.service.in";
      sha256 = "0jvmi1c98hm8x1x7kw9ws0nbf4y56yy44c3bqm6rjj4lrm89l83s";
    })
    (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/phuhl/linux_notification_center/blob/${version}/deadd-notification-center.service.in";
      sha256 = "18rrk896w5x4dflbxfm2nhhx300f2dicychqlw151idxld4fsnfq";
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
 
  installPhase = with lib; ''
    mkdir -p $out/bin
    install -m755 ${elemAt srcs 0} $out/bin

    sed "s|##PREFIX##|$out/bin|" ${elemAt srcs 1} > $out/com.ph-uhl.deadd.notification.service
    mkdir -p $out/share/dbus-1/services
    install -m644 $out/com.ph-uhl.deadd.notification.service $out/share/dbus-1/services

    sed "s|##PREFIX##|$out/bin|" ${elemAt srcs 2} > $out/deadd-notification-center.service
    mkdir -p $out/lib/systemd/services
    install -m644 $out/deadd-notification-center.service $out/lib/systemd/services
  '';

  meta = with lib; {
    homepage = https://github.com/phuhl/linux_notification_center;
    description = "A haskell-written notification center for users that like a desktop with style…";
    platforms = platforms.all;
    maintainers = with maintainers; [ ph-uhl ];
  };
}
