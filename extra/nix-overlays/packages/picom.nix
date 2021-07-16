{ pkgs
, withDebug ? false
}:

pkgs.stdenv.mkDerivation rec {
  pname = "picom";
  version = "Next";

  src = pkgs.fetchFromGitHub {
    owner = "yshui";
    repo = "picom";
    rev = "v${version}";
    sha256 = "0asp2hg1jx909kl7i876mcx00vwg9w2swr9i6d786iwgs247dc9i";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with pkgs; [
    asciidoc
    docbook_xml_dtd_45
    docbook_xsl
    makeWrapper
    meson
    ninja
    pkg-config
    uthash
  ];

  buildInputs = with pkgs; [
    dbus
    libconfig
    libdrm
    libev
    libGL
    xorg.libX11
    xorg.libxcb
    libxdg_basedir
    xorg.libXext
    xorg.libXinerama
    libxml2
    libxslt
    pcre
    pixman
    xorg.xcbutilimage
    xorg.xcbutilrenderutil
    xorg.xorgproto
  ];

  # Use "debugoptimized" instead of "debug" so perhaps picom works better in
  # normal usage too, not just temporary debugging.
  mesonBuildType = if withDebug then "debugoptimized" else "release";
  dontStrip = withDebug;

  mesonFlags = [
    "-Dwith_docs=true"
  ];

  installFlags = [ "PREFIX=$(out)" ];

  # In debug mode, also copy src directory to store. If you then run `gdb picom`
  # in the bin directory of picom store path, gdb finds the source files.
  postInstall = ''
    wrapProgram $out/bin/picom-trans \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.xorg.xwininfo ]}
  '' + pkgs.lib.optionalString withDebug ''
    cp -r ../src $out/
  '';

  meta = with pkgs.lib; {
    description = "A fork of XCompMgr, a sample compositing manager for X servers";
    longDescription = ''
      A fork of XCompMgr, which is a sample compositing manager for X
      servers supporting the XFIXES, DAMAGE, RENDER, and COMPOSITE
      extensions. It enables basic eye-candy effects. This fork adds
      additional features, such as additional effects, and a fork at a
      well-defined and proper place.
      The package can be installed in debug mode as:
        picom.override { withDebug = true; }
      For gdb to find the source files, you need to run gdb in the bin directory
      of picom package in the nix store.
    '';
    license = licenses.mit;
    homepage = "https://github.com/yshui/picom";
    maintainers = with maintainers; [ ertes twey thiagokokada ];
    platforms = platforms.linux;
  };
}
