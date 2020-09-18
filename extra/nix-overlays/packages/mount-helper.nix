{ pkgs
, stdenv ? pkgs.stdenv }:

let
  blkid = "${pkgs.utillinux}/bin/blkid";
  awk = "${pkgs.gawk}/bin/awk";
  cut = "${pkgs.coreutils}/bin/cut";
  mount_ = "${pkgs.utillinux}/bin/mount";
  mkdir = "${pkgs.coreutils}/bin/mkdir";
  id = "${pkgs.coreutils}/bin/id";
  echo = "${pkgs.coreutils}/bin/echo";
  chown = "${pkgs.coreutils}/bin/chown";

  mount = pkgs.writeScriptBin "mount-helper" ''
    #!${stdenv.shell}

    VERBOSE=''${VERBOSE:-0}

    if (( $# != 1 )); then
      ${echo} "Usage: mount-helper DISK"
      exit 1
    fi

    SUDO=
    if (( ''${EUID:-$(${id} -u)} != 0 )); then
      SUDO='sudo'
    fi

    DISK=$1
    MOUNTPOINT=`$SUDO ${blkid} $DISK | ${awk} '{print $5}' | ${cut} -d "=" -f 2 | ${cut} -d '"' -f 2`
    # ^^^^ Retrieves the PARTUUID of the disk
    TARGET=/run/media/$USER/$MOUNTPOINT

    if ! [ -d /run/media/$USER ]; then
      if (( $VERBOSE == 1 )); then
        ${echo} "$SUDO ${mkdir} /run/media/$USER -p"
      fi

      $SUDO ${mkdir} /run/media/$USER -p
    fi

    if (( $VERBOSE == 1 )); then
      ${echo} "$SUDO ${mkdir} -p $TARGET &> /dev/null"
    fi

    $SUDO ${mkdir} -p $TARGET &> /dev/null
    # ^^^^ There can be two errors:
    # - The script is not run as `sudo`. It should fail before this step then.
    # - The directory already exists: ignore it.

    if (( $VERBOSE == 1 )); then
      ${echo} "$SUDO ${chown} $USER:users /run/media/$USER"
      ${echo} "$SUDO ${chown} $USER:users $TARGET"
    fi

    $SUDO ${chown} $USER:users /run/media/$USER
    $SUDO ${chown} $USER:users $TARGET

    if (( $VERBOSE == 1 )); then
      ${echo} "$SUDO ${mount_} $DISK $TARGET -rw -o umask=000"
    fi

    $SUDO ${mount_} $DISK $TARGET -rw -o umask=000 && ${echo} "Mounted $DISK on '$TARGET'"
  '';
in
mount
