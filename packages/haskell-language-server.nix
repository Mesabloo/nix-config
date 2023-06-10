{ pkgs
, stdenv ? pkgs.sdtenv
}:

stdenv.mkDerivation rec {
  name = "haskell-language-server";
  version = "1.1.0";

  src = pkgs.fetchurl {
    url = "https://github.com/haskell/haskell-language-server/releases/download/${version}/haskell-language-server-Linux-${version}.tar.gz";
    sha256 = "13r04b2sm8gj71zp7qjbjndra0b8ccfdfpsnixjp70m0x6qas38g";
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
