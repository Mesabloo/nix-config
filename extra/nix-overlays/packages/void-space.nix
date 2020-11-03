{ pkgs
, stdenv ? pkgs.stdenv
}:

/*

Copyright Chris Penner (c) 2018

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.

    * Neither the name of Chris Penner nor the names of other
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

*/


stdenv.mkDerivation {
  name = "void-space";
  version = "1.0.0";

  src = ./void-space-exe;

  buildInputs = with pkgs; [
    autoPatchelfHook

    ncurses
    gmp
    libffi
  ];

  dontUnpack = true;
  dontBuild = true;

  unpackPhase = ":";
  buildPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    install -m755 $src $out/bin/void-space
  '';
}
