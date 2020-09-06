{ pkgs, lib, options, config, ... }:

with lib;
{
  options.modules.dev.scala = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.scala.enable {
    home.packages = with pkgs; [
      sbt-with-scala-native
      scala
      scalafmt
      scalafix
    ];
  };
}
