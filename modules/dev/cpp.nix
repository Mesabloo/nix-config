# C++? Why the fuck am I using this language?

{ pkgs, lib, config, options, ... }:

with lib;
{
  options.modules.dev.cpp = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.cpp.enable {
    home.packages = with pkgs; [
      autoconf

      # clang
      # ^^^^^ Conflicts with gcc
      cmake     # prefered build manager

      gcc       # C and C++ compilers (mostly)
      gdb       # ehhhhhhh, we need to debug this
      glibc     # a simple C standard library
      gnumake   # just make your programs into executables

      libgcc

      scons     # another build manager, scriptable in python
    ];
  };
}
