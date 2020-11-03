{ pkgs
, stdenv ? pkgs.sdtenv
}:

stdenv.mkDerivation rec {
  name = "haskell-language-server";
  version = "0.5.1";

  src = pkgs.fetchurl {
    url = "https://github.com/haskell/haskell-language-server/releases/download/${version}/haskell-language-server-Linux-${version}.tar.gz";
    sha256 = "1ss4p1y7d2brcyjawbxsjczpnvwy69mzirid6bcv2crhh9isd04g";
  };

  buildInputs = with pkgs; [
    icu
    zlib
    ncurses

    autoPatchelfHook
  ];

  unpackPhase = ''
    if ! [ -d $out ]; then
      mkdir -p $out
    fi

    tar -xf $src -C $out
  '';

  installPhase = ''
    mkdir -p $out/bin

    # install all executables
    for exe in $out/haskell-language-server-*; do
      install -m755 $exe $out/bin
    done

    rm $out/haskell-language-server-*
  '';
}
