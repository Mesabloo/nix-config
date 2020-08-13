{ pkgs
, stdenv ? pkgs.stdenv }:

let
  mount = pkgs.writeScriptBin "mount-helper" ''
    #!${stdenv.shell}

    if (( $# != 1 )); then
      echo "Usage: mount-helper DISK"
      exit 1
    fi

    SUDO=
    if (( ''${EUID:-$(id -u)} != 0 )); then
      SUDO='sudo'
    fi

    DISK=$1
    MOUNTPOINT=`blkid $DISK | cut -d " " -f 8 | cut -d "=" -f 2 | cut -d '"' -f 2`
    # ^^^^ Retrieves the PARTUUID of the disk
    TARGET=/run/media/$USER/$MOUNTPOINT

    $SUDO mkdir -p $TARGET &> /dev/null
    # ^^^^ There can be two errors:
    # - The script is not run as `sudo`. It should fail before this step then.
    # - The directory already exists: ignore it.

    $SUDO mount $DISK $TARGET
  '';
in
mount
