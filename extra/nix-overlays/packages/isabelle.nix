{ lib, stdenv, fetchurl, coreutils, nettools, jdk, polyml, z3, veriT, vampire, eprover-ho, naproche, rlwrap, perl, makeDesktopItem, isabelle-components, isabelle, symlinkJoin, fetchhg, curl, spass }:
# nettools needed for hostname

let
  sha1 = stdenv.mkDerivation {
    pname = "isabelle-sha1";
    version = "2021-1";

    src = fetchhg {
      url = "https://isabelle.sketis.net/repos/sha1";
      rev = "e0239faa6f42";
      sha256 = "sha256-4sxHzU/ixMAkSo67FiE6/ZqWJq9Nb9OMNhMoXH2bEy4=";
    };

    buildPhase = (if stdenv.isDarwin then ''
      LDFLAGS="-dynamic -undefined dynamic_lookup -lSystem"
    '' else ''
      LDFLAGS="-fPIC -shared"
    '') + ''
      CFLAGS="-fPIC -I."
      $CC $CFLAGS -c sha1.c -o sha1.o
      $LD $LDFLAGS sha1.o -o libsha1.so
    '';

    installPhase = ''
      mkdir -p $out/lib
      cp libsha1.so $out/lib/
    '';
  };

  java = jdk;

  contrib-apache-commons = fetchurl {
    url = "https://isabelle.sketis.net/components/apache-commons-20211211.tar.gz";
    sha256 = "sha256-fP37+sHgNYla/S4/kel6f++1viCgvNPXL4wWVtcQwKI=";
  };
  contrib-bash_process = fetchurl {
    url = "https://isabelle.sketis.net/components/bash_process-1.3.tar.gz";
    sha256 = "sha256-GLLiYA1IA3lajrW2mN3eZtc4saO3XfwrdG7jP97DSvU=";
  };
  contrib-bib2xhtml = fetchurl {
    url = "https://isabelle.sketis.net/components/bib2xhtml-20190409.tar.gz";
    sha256 = "sha256-vidKO5SoZSRGcpQ5FrDLPj44jG04+c/DQuQb6zCaCLw=";
  };
  contrib-csdp = fetchurl {
    url = "https://isabelle.sketis.net/components/csdp-6.1.1.tar.gz";
    sha256 = "sha256-XqQclPLFbJgV+hDcf2+Qjq6gDo/Xt8m00Oa9/VT+1eM=";
  };
  contrib-cvc4 = fetchurl {
    url = "https://isabelle.sketis.net/components/cvc4-1.8.tar.gz";
    sha256 = "sha256-ZmKhzKRjMItLBAffyFvdCLAAv8ZZ27N9ssA0wnHmoKM=";
  };
  contrib-e = fetchurl {
    url = "https://isabelle.sketis.net/components/e-2.6-1.tar.gz";
    sha256 = "sha256-G/Wb4LMh6Hr6LeyYygHh+yB38BpcazzscSj1mbBqxxc=";
  };
  contrib-flatlaf = fetchurl {
    url = "https://isabelle.sketis.net/components/flatlaf-2.4.tar.gz";
    sha256 = "sha256-AU+nssu1YwWxkXs2Z2R+y9xPnNxGYkWuq4h6lKejlwo=";
  };
  contrib-gnu-utils = fetchurl {
    url = "https://isabelle.sketis.net/components/gnu-utils-20211030.tar.gz";
    sha256 = "sha256-cOQtTgNdqeDqn1bmN0SXNbyUUfoD/xTMDhJWsI/NsVY=";
  };
  contrib-idea-icons = fetchurl {
    url = "https://isabelle.sketis.net/components/idea-icons-20210508.tar.gz";
    sha256 = "sha256-2ZuHFSpNDyA23HaWUVRCX2ACtcVuc8qP5hIaxbtoztY=";
  };
  contrib-isabelle_fonts = fetchurl {
    url = "https://isabelle.sketis.net/components/isabelle_fonts-20211004.tar.gz";
    sha256 = "sha256-0Q/LhAdVD1tpBnug7z/++LCFalsmwLoVE81oyz6nwHM=";
  };
  contrib-isabelle_setup = fetchurl {
    url = "https://isabelle.sketis.net/components/isabelle_setup-20221020.tar.gz";
    sha256 = "sha256-OBUH+B3EuTfFtSMW2GyN9Phta1ThFfKGZbfjeWUAXg0=";
  };
  contrib-jdk = fetchurl {
    url = "https://isabelle.sketis.net/components/jdk-17.0.4.1+1.tar.gz";
    sha256 = "sha256-uh6xcVOZoB9W//Z8p+Lrsc+iQjx7HpFlWOeYKur/pPM=";
  };
  contrib-jedit = fetchurl {
    url = "https://isabelle.sketis.net/components/jedit-20211103.tar.gz";
    sha256 = "sha256-XFIP5ZUDqtCHQHMWDchqX4eQNky7hNf5SSBwh0ICacw=";
  };
  contrib-jfreechart = fetchurl {
    url = "https://isabelle.sketis.net/components/jfreechart-1.5.3.tar.gz";
    sha256 = "sha256-39Un5RC9xi6252ZsPaUm2SDr3GaFc1KLvEJ+cphwEbs=";
  };
  contrib-jortho = fetchurl {
    url = "https://isabelle.sketis.net/components/jortho-1.0-2.tar.gz";
    sha256 = "sha256-zwBNc1JS3NwA/208m1zEAPVryLfrSe2aMifxJ3ljm60=";
  };
  contrib-kodkodi = fetchurl {
    url = "https://isabelle.sketis.net/components/kodkodi-1.5.7.tar.gz";
    sha256 = "sha256-BY5I2vLexZwTJnhSIIPciv08Cby4E8OhGpKNPO+RDqE=";
  };
  contrib-minisat = fetchurl {
    url = "https://isabelle.sketis.net/components/minisat-2.2.1-1.tar.gz";
    sha256 = "sha256-5qLiSm6Pas+CWYB8CRL5aGGZsW0LCsp0WQmulMOKWwo=";
  };
  contrib-mlton = fetchurl {
    url = "https://isabelle.sketis.net/components/mlton-20210117-1.tar.gz";
    sha256 = "sha256-eVG18iGBc9bWxWlE30Dd5QZ8iPjgTDwpvmAZBXkYlVo=";
  };
  contrib-naproche = fetchurl {
    url = "https://isabelle.sketis.net/components/naproche-20221024.tar.gz";
    sha256 = "sha256-DSNihlI4jypkq9LhQhbbCcsPwecIv5qrmr3AU8F/+Nw=";
  };
  contrib-nunchaku = fetchurl {
    url = "https://isabelle.sketis.net/components/nunchaku-0.5.tar.gz";
    sha256 = "sha256-uCjuB5Eps0+cRvUqDA5DX6/TaJ7V2femW3s9QDS6Mhs=";
  };
  contrib-opam = fetchurl {
    url = "https://isabelle.sketis.net/components/opam-2.0.7.tar.gz";
    sha256 = "sha256-HWhitk6BxFrOnJSdLY9BpsuFZWfFq49YLfSy1oBqI28=";
  };
  contrib-pdfjs = fetchurl {
    url = "https://isabelle.sketis.net/components/pdfjs-2.14.305.tar.gz";
    sha256 = "sha256-6uSjn2525xfLn3pE2q2faYTclZwIXsMwhZ5Oo0ZArX8=";
  };
  contrib-polyml = fetchurl {
    url = "https://isabelle.sketis.net/components/polyml-test-bafe319bc3a6-1.tar.gz";
    sha256 = "sha256-X+YRSeS5+5mOdjfMSSq0FvfiOtjB5UNPrLThnFIci4M=";
  };
  contrib-postgresql = fetchurl {
    url = "https://isabelle.sketis.net/components/postgresql-42.5.0.tar.gz";
    sha256 = "sha256-Hph41kkDAKi8RlzZ/kH5wpj65Njpne9h7ghW5U9xiVk=";
  };
  contrib-scala = fetchurl {
    url = "https://isabelle.sketis.net/components/scala-3.2.0-2.tar.gz";
    sha256 = "sha256-ewPx/ecHipfmyG2p3eOaufbTjpTGF9wrlBiF0o27Asg=";
  };
  contrib-smbc = fetchurl {
    url = "https://isabelle.sketis.net/components/smbc-0.4.1.tar.gz";
    sha256 = "sha256-pOBxR0+F4Yaaoaz8nM1Lfn9D+cIFTPxvBUpPR5Hh6f8=";
  };
  contrib-spass = fetchurl {
    url = "https://isabelle.sketis.net/components/spass-3.8ds-2.tar.gz";
    sha256 = "sha256-ZL61lR+fQUB83oBFPXn6rwJH2m/25PqJiC2WcCWkEUw=";
  };
  contrib-sqlite-jdbc = fetchurl {
    url = "https://isabelle.sketis.net/components/sqlite-jdbc-3.36.0.3.tar.gz";
    sha256 = "sha256-SYI9N5865nsDCVuKyCBp865rj8Q16HPZOCgNkh3S2IA=";
  };
  contrib-stack = fetchurl {
    url = "https://isabelle.sketis.net/components/stack-2.7.3.tar.gz";
    sha256 = "sha256-L0qhJGzaXat2DYnpr4E385GQeLzuvFRpKIELTKHTuX0=";
  };
  contrib-vampire = fetchurl {
    url = "https://isabelle.sketis.net/components/vampire-4.6.tar.gz";
    sha256 = "sha256-tgxlfK2AlO2DDrT4h6lOpzGqfePg18R0VL5scey3sTw=";
  };
  contrib-verit = fetchurl {
    url = "https://isabelle.sketis.net/components/verit-2021.06.2-rmx.tar.gz";
    sha256 = "sha256-SD0GGqCqkg7KaKeyb69bFEFKNDvojt/BxxRmSk7MDw8=";
  };
  contrib-xz-java = fetchurl {
    url = "https://isabelle.sketis.net/components/xz-java-1.9.tar.gz";
    sha256 = "sha256-Cmal9ykBRs/wFbZTnM6afF4fC+QCYzsUyeapj9HmDNw=";
  };
  contrib-z3 = fetchurl {
    url = "https://isabelle.sketis.net/components/z3-4.4.0_4.4.1.tar.gz";
    sha256 = "sha256-Wks0WOAYSlAFNSszUKwYYciYJTUOS7Vg1p06HnRe8gg=";
  };
  contrib-zipperposition = fetchurl {
    url = "https://isabelle.sketis.net/components/zipperposition-2.1-1.tar.gz";
    sha256 = "sha256-zZCvE4HYd2O2trdqtT+NUee+3JnksxewTxgrDvFD2uI=";
  };
in
stdenv.mkDerivation
  rec {
    pname = "isabelle";
    version = "2022";

    dirname = "Isabelle${version}";

    src =
      if stdenv.isDarwin
      then
        fetchurl
          {
            url = "https://isabelle.in.tum.de/website-${dirname}/dist/${dirname}_macos.tar.gz";
            sha256 = "0n1ls9vwf0ps1x8zpb7c1xz1wkasgvc34h5bz280hy2z6iqwmwbc";
          }
      else
        fetchurl {
          url = "https://github.com/m-fleury/isabelle-emacs/archive/${dirname}-RC4-more-vscode.tar.gz";
          sha256 = "sha256-lDoqIu4UrJ8lcjPj+vuX1tx7Jk0Q0QJu9yiz+8mKFZc=";
        };

    buildInputs = [ polyml z3 veriT vampire eprover-ho nettools curl ]
    ++ lib.optionals (!stdenv.isDarwin) [ java ];

    # sourceRoot = "${dirname}${lib.optionalString stdenv.isDarwin ".app"}";
    sourceRoot = "isabelle-emacs-${dirname}-RC4-more-vscode";

    postUnpack =
      ''
        mv $sourceRoot ${dirname}
        sourceRoot=${dirname}
        
        OLD_PWD=$(pwd)
        mkdir $sourceRoot/contrib
        cd $sourceRoot/contrib 

        echo 'unpacking source archive ${contrib-apache-commons}'
        tar -xf ${contrib-apache-commons}
        echo 'unpacking source archive ${contrib-bash_process}'
        tar -xf ${contrib-bash_process}
        echo 'unpacking source archive ${contrib-bib2xhtml}'
        tar -xf ${contrib-bib2xhtml}
        echo 'unpacking source archive ${contrib-csdp}'
        tar -xf ${contrib-csdp}
        echo 'unpacking source archive ${contrib-cvc4}'
        tar -xf ${contrib-cvc4}
        # E prover
        echo 'unpacking source archive ${contrib-flatlaf}'
        tar -xf ${contrib-flatlaf}
        echo 'unpacking source archive ${contrib-gnu-utils}'
        tar -xf ${contrib-gnu-utils}
        echo 'unpacking source archive ${contrib-idea-icons}'
        tar -xf ${contrib-idea-icons}
        echo 'unpacking source archive ${contrib-isabelle_fonts}'
        tar -xf ${contrib-isabelle_fonts}
        echo 'unpacking source archive ${contrib-isabelle_setup}'
        tar -xf ${contrib-isabelle_setup}
        # JDK
        echo 'unpacking source archive ${contrib-jedit}'
        tar -xf ${contrib-jedit}
        echo 'unpacking source archive ${contrib-jfreechart}'
        tar -xf ${contrib-jfreechart}
        echo 'unpacking source archive ${contrib-jortho}'
        tar -xf ${contrib-jortho}
        echo 'unpacking source archive ${contrib-kodkodi}'
        tar -xf ${contrib-kodkodi}
        echo 'unpacking source archive ${contrib-minisat}'
        tar -xf ${contrib-minisat}
        echo 'unpacking source archive ${contrib-mlton}'
        tar -xf ${contrib-mlton}
        echo 'unpacking source archive ${contrib-naproche}'
        tar -xf ${contrib-naproche}
        echo 'unpacking source archive ${contrib-nunchaku}'
        tar -xf ${contrib-nunchaku}
        echo 'unpacking source archive ${contrib-opam}'
        tar -xf ${contrib-opam}
        echo 'unpacking source archive ${contrib-pdfjs}'
        tar -xf ${contrib-pdfjs}
        # PolyML
        echo 'unpacking source archive ${contrib-postgresql}'
        tar -xf ${contrib-postgresql}
        echo 'unpacking source archive ${contrib-scala}'
        tar -xf ${contrib-scala}
        echo 'unpacking source archive ${contrib-smbc}'
        tar -xf ${contrib-smbc}
        echo 'unpacking source archive ${contrib-spass}'
        tar -xf ${contrib-spass}
        echo 'unpacking source archive ${contrib-sqlite-jdbc}'
        tar -xf ${contrib-sqlite-jdbc}
        echo 'unpacking source archive ${contrib-stack}'
        tar -xf ${contrib-stack}
        # Vampire
        # VeriT
        echo 'unpacking source archive ${contrib-xz-java}'
        tar -xf ${contrib-xz-java}
        # Z3
        echo 'unpacking source archive ${contrib-zipperposition}'
        tar -xf ${contrib-zipperposition}

        cd $OLD_PWD
      '';

    postPatch = ''
      patchShebangs .

      mkdir -p \
        contrib/z3-4.4.0_4.4.1/etc \
        contrib/verit-2021.06.2-rmx/etc \
        contrib/e-2.6-1/etc \
        contrib/vampire-4.6/etc \
        contrib/polyml-test-bafe319bc3a6-1/etc \
        contrib/jdk-17.0.4.1+1/etc
      
      cat >contrib/z3-4.4.0_4.4.1/etc/settings <<EOF
        Z3_HOME=${z3}
        Z3_VERSION=${z3.version}
        Z3_SOLVER=${z3}/bin/z3
        Z3_INSTALLED=yes
      EOF

      cat >contrib/verit-2021.06.2-rmx/etc/settings <<EOF
        ISABELLE_VERIT=${veriT}/bin/veriT
      EOF

      cat >contrib/e-2.6-1/etc/settings <<EOF
        E_HOME=${eprover-ho}/bin
        E_VERSION=${eprover-ho.version}
      EOF

      cat >contrib/vampire-4.6/etc/settings <<EOF
        VAMPIRE_HOME=${vampire}/bin
        VAMPIRE_VERSION=${vampire.version}
        VAMPIRE_EXTRA_OPTIONS="--mode casc"
      EOF

      cat >contrib/polyml-test-bafe319bc3a6-1/etc/settings <<EOF
        ML_SYSTEM_64=true
        ML_SYSTEM=${polyml.name}
        ML_PLATFORM=${stdenv.system}
        ML_HOME=${polyml}/bin
        ML_OPTIONS="--minheap 1000"
        POLYML_HOME="\$COMPONENT"
        ML_SOURCES="\$POLYML_HOME/src"
      EOF

      cat >contrib/jdk-17.0.4.1+1/etc/settings <<EOF
        ISABELLE_JAVA_PLATFORM=${stdenv.system}
        ISABELLE_JDK_HOME=${java}
      EOF

      cat >etc/components <<EOF
      #built-in components
      src/Tools/jEdit
      src/Tools/GraphBrowser
      src/Tools/Graphview
      src/Tools/Setup
      src/Tools/VSCode
      src/HOL/Mutabelle
      src/HOL/Library/Sum_of_Squares
      src/HOL/SPARK
      src/HOL/Tools
      src/HOL/TPTP
      #bundled components
      contrib/gnu-utils-20211030
      contrib/apache-commons-20211211
      contrib/bash_process-1.3
      contrib/bib2xhtml-20190409
      contrib/csdp-6.1.1
      contrib/cvc4-1.8
      contrib/e-2.6-1
      contrib/flatlaf-2.4
      contrib/idea-icons-20210508
      contrib/isabelle_fonts-20211004
      contrib/isabelle_setup-20221020
      contrib/jdk-17.0.4.1+1
      contrib/jedit-20211103
      contrib/jfreechart-1.5.3
      contrib/jortho-1.0-2
      contrib/kodkodi-1.5.7
      contrib/minisat-2.2.1-1
      contrib/mlton-20210117-1
      contrib/nunchaku-0.5
      contrib/opam-2.0.7
      contrib/pdfjs-2.14.305
      contrib/polyml-test-bafe319bc3a6-1
      contrib/postgresql-42.5.0
      contrib/scala-3.2.0-2
      contrib/smbc-0.4.1
      contrib/spass-3.8ds-2
      contrib/sqlite-jdbc-3.36.0.3
      contrib/stack-2.7.3
      contrib/vampire-4.6
      contrib/verit-2021.06.2-rmx
      #contrib/vscode_extension-20220829
      #contrib/vscodium-1.70.1
      contrib/xz-java-1.9
      contrib/z3-4.4.0_4.4.1
      contrib/zipperposition-2.1-1
      contrib/naproche-20221024
      EOF

      # rm contrib/naproche-*/x86*/Naproche-SAD
      # ln -s ${naproche}/bin/Naproche-SAD contrib/naproche-*/x86*/

      echo ISABELLE_LINE_EDITOR=${rlwrap}/bin/rlwrap >>etc/settings

      for comp in contrib/jdk* contrib/polyml-* contrib/z3-* contrib/verit-* contrib/vampire-* contrib/e-*; do
        rm -rf $comp/x86*
      done

      substituteInPlace lib/Tools/env \
        --replace /usr/bin/env ${coreutils}/bin/env

      substituteInPlace src/Tools/Setup/src/Environment.java \
        --replace 'cmd.add("/usr/bin/env");' "" \
        --replace 'cmd.add("bash");' "cmd.add(\"$SHELL\");" \
        --replace 'private static read_file(path: Path): String =' 'private static String read_file(Path path)'

      substituteInPlace src/Pure/General/sha1.ML \
        --replace '"$ML_HOME/" ^ (if ML_System.platform_is_windows then "sha1.dll" else "libsha1.so")' '"${sha1}/lib/libsha1.so"'

      # rm -r heaps
    '' + lib.optionalString (stdenv.hostPlatform.system == "x86_64-darwin") ''
      substituteInPlace lib/scripts/isabelle-platform \
        --replace 'ISABELLE_APPLE_PLATFORM64=arm64-darwin' ""
    '' + (if ! stdenv.isLinux then "" else ''
      arch=${if stdenv.hostPlatform.system == "x86_64-linux" then "x86_64-linux" else "x86-linux"}
      for f in contrib/*/$arch/{epclextract,nunchaku,SPASS,zipperposition}; do
        patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) "$f"
      done
      for f in contrib/*/platform_$arch/{bash_process,SPASS}; do
        patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) "$f"
      done
      for d in contrib/kodkodi-*/jni/$arch; do
        patchelf --set-rpath "${lib.concatStringsSep ":" [ "${java}/lib/openjdk/lib/server" "${stdenv.cc.cc.lib}/lib" ]}" $d/*.so
      done
    '');

    # patches = [
    #   ./isabelle_src_Pure_ML_ml_statistics.ML.patch
    #   ./isabelle_src_Pure_General_integer.ML.patch
    # ];

    buildPhase = ''
      export HOME=$TMP # The build fails if home is not set
      setup_name=$(basename contrib/isabelle_setup*)

      SCALA_DIR=$(basename contrib/scala-*)

      #The following is adapted from https://isabelle.sketis.net/repos/isabelle/file/Isabelle2021-1/Admin/lib/Tools/build_setup
      TARGET_DIR="contrib/$setup_name/lib"
      rm -rf "$TARGET_DIR"
      mkdir -p "$TARGET_DIR/isabelle/setup"
      declare -a ARGS=("-Xlint:unchecked")

      SOURCES="$(${perl}/bin/perl -e 'while (<>) { if (m/(\S+\.java)/)  { print "$1 "; } }' "src/Tools/Setup/etc/build.props")"
      for SRC in $SOURCES
      do
        ARGS["''${#ARGS[@]}"]="src/Tools/Setup/$SRC"
      done
      
      ${java}/bin/javac -d "$TARGET_DIR" -classpath "contrib/$SCALA_DIR/lib/*" "''${ARGS[@]}"
      ${java}/bin/jar -c -f "$TARGET_DIR/isabelle_setup.jar" -e "isabelle.setup.Setup" -C "$TARGET_DIR" isabelle
      rm -rf "$TARGET_DIR/isabelle"

      # Prebuild HOL Session
      bin/isabelle build -v -o system_heaps -b HOL
    '';

    installPhase = ''
      mkdir -p $out/bin
      mv $TMP/$dirname $out
      cd $out/$dirname
      bin/isabelle install $out/bin

      # icon
      mkdir -p "$out/share/icons/hicolor/isabelle/apps"
      cp "$out/Isabelle${version}/lib/icons/isabelle.xpm" "$out/share/icons/hicolor/isabelle/apps/"

      # desktop item
      mkdir -p "$out/share"
      cp -r "${desktopItem}/share/applications" "$out/share/applications"
    '';

    desktopItem = makeDesktopItem {
      name = "isabelle";
      exec = "isabelle jedit";
      icon = "isabelle";
      desktopName = "Isabelle";
      comment = meta.description;
      categories = [ "Education" "Science" "Math" ];
    };

    meta = with lib; {
      description = "A generic proof assistant";

      longDescription = ''
        Isabelle is a generic proof assistant.  It allows mathematical formulas
        to be expressed in a formal language and provides tools for proving those
        formulas in a logical calculus.
      '';
      homepage = "https://isabelle.in.tum.de/";
      sourceProvenance = with sourceTypes; [
        fromSource
        binaryNativeCode # source bundles binary dependencies
      ];
      license = licenses.bsd3;
      maintainers = [ maintainers.jwiegley maintainers.jvanbruegge ];
      platforms = platforms.unix;
    };
  } // {
  withComponents = f:
    let
      base = "$out/${isabelle.dirname}";
      components = f isabelle-components;
    in
    symlinkJoin {
      name = "isabelle-with-components-${isabelle.version}";
      paths = [ isabelle ] ++ components;

      postBuild = ''
        rm $out/bin/*

        cd ${base}
        rm bin/*
        cp ${isabelle}/${isabelle.dirname}/bin/* bin/
        rm etc/components
        cat ${isabelle}/${isabelle.dirname}/etc/components > etc/components

        export HOME=$TMP
        bin/isabelle install $out/bin
        patchShebangs $out/bin
      '' + lib.concatMapStringsSep "\n"
        (c: ''
          echo contrib/${c.pname}-${c.version} >> ${base}/etc/components
        '')
        components;
    };
}
