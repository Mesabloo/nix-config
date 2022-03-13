{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "nbtexplorer";
  version = "2.8.0";

  src = pkgs.fetchurl {
    url = "https://github.com/jaquadro/NBTExplorer/releases/download/v${version}-win/NBTExplorer-${version}.zip";
    sha256 = "0jvfcsd543qbsawwybfrcw9w01gizc9cqwvc3j8vm3qfdbjw7x0v";
  };

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  setSourceRoot = "sourceRoot=`pwd`";

  buildInputs = with pkgs; [
    mono
  ];

  nativeBuildInputs = with pkgs; [
    unzip
  ];

  installPhase = ''
    mkdir -p $out/bin

    cp NBTExplorer.exe $out/bin/
    cp NBTExplorer.exe.config $out/bin/
    cp NBTModel.dll $out/bin/
    cp NBTUtil.exe $out/bin/
    cp NBTUtil.exe.config $out/bin/
    cp Substrate.dll $out/bin/

    touch $out/bin/NBTExplorer
    touch $out/bin/NBTUtil

    echo "#!/bin/bash
    ${pkgs.mono}/bin/mono $out/bin/NBTExplorer.exe \$@" > $out/bin/NBTExplorer
    echo "#!/bin/bash
    ${pkgs.mono}/bin/mono $out/bin/NBTUtil.exe \$@" > $out/bin/NBTUtil

    chmod +x $out/bin/NBTExplorer
    chmod +x $out/bin/NBTUtil
  '';
}
