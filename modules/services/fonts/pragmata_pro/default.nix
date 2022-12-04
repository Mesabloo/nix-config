{ stdenv }:

stdenv.mkDerivation rec {
  name = "pragmata-pro";
  version = "1.0";
  src = ./.;

  installPhase = ''
    install -D ${src}/Pragmata_Pro_Bold_Italic.otf $out/share/fonts/opentype/Pragmata\ Pro\ Bold\ Italic.otf
    install -D ${src}/Pragmata_Pro_Bold\.otf $out/share/fonts/opentype/Pragmata\ Pro\ Bold\.otf
    install -D ${src}/Pragmata_Pro_Italic.otf $out/share/fonts/opentype/Pragmata\ Pro\ Italic.otf
    install -D ${src}/Pragmata_Pro_Mono_Bold_Italic.otf $out/share/fonts/opentype/Pragmata\ Pro\ Mono\ Bold\ Italic.otf
    install -D ${src}/Pragmata_Pro_Mono_Bold.otf $out/share/fonts/opentype/Pragmata\ Pro\ Mono\ Bold.otf
    install -D ${src}/Pragmata_Pro_Mono_Italic.otf $out/share/fonts/opentype/Pragmata\ Pro\ Mono\ Italic.otf
    install -D ${src}/Pragmata_Pro_Mono_Regular.otf $out/share/fonts/opentype/Pragmata\ Pro\ Mono\ Regular.otf
    install -D ${src}/Pragmata_Pro_Regular.otf $out/share/fonts/opentype/Pragmata\ Pro\ Regular.otf
  '';
}
