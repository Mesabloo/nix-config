# C++? Why the fuck am I using this language?

{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.dev.cpp = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    qt = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };

      editor = mkOption {
        type = types.package;
        default = pkgs.qtcreator;
      };
    };
  };

  config = mkIf (config.modules.dev.cpp.enable || config.modules.dev.cpp.qt.enable) {
    home.packages = with pkgs; [
      autoconf

      # clang
      # ^^^^^ Conflicts with gcc
      cmake     # prefered build manager

      doxygen   # because we want to write some documentation

      gcc       # C and C++ compilers (mostly)
      gdb       # ehhhhhhh, we need to debug this
      glibc     # a simple C standard library
      gnumake   # just make your programs into executables

      libgcc

      scons     # another build manager, scriptable in python
    ] ++
	(if config.modules.dev.cpp.qt.enable
	 then [
	   config.modules.dev.cpp.qt.editor
           qt5.full
           qt5.qmake
	 ]
	 else []);
  };
}
