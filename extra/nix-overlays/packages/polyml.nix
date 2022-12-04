{ lib
, stdenv
, fetchFromGitHub
, autoreconfHook
, gmp
, libffi
}:

stdenv.mkDerivation rec {
  pname = "polyml";
  version = "bafe319bc3a65bf63bd98a4721a6f4dd9e0eabd6";

  prePatch = lib.optionalString stdenv.isDarwin ''
    substituteInPlace configure.ac --replace stdc++ c++
  '';

  buildInputs = [ libffi gmp ];

  nativeBuildInputs = lib.optional stdenv.isDarwin autoreconfHook;

  configureFlags = [
    "--enable-shared"
    "--with-system-libffi"
    "--with-gmp"
    # this is needed for isabelle
    "--enable-intinf-as-int"
  ];

  src = fetchFromGitHub {
    owner = "polyml";
    repo = "polyml";
    rev = "bafe319bc3a65bf63bd98a4721a6f4dd9e0eabd6";
    sha256 = "sha256-4oo4AB54CivhS99RuZVTP9+Ic0CDpsBb+OiHvOhmZnN=";
  };

  meta = with lib; {
    description = "Standard ML compiler and interpreter";
    longDescription = ''
      Poly/ML is a full implementation of Standard ML.
    '';
    homepage = "https://www.polyml.org/";
    license = licenses.lgpl21;
    platforms = with platforms; (linux ++ darwin);
    maintainers = with maintainers; [ maggesi kovirobi ];
  };
}
