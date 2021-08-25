{ pkgs, options, config, lib, ... }:

with lib;

let
  coordModule = types.submodule {
    options = {
      relative = mkOption { type = types.either types.float types.int; };
      offset = mkOption { type = types.either types.float types.int; };
    };
  };

  colorModule = types.submodule {
    options = {
      bg = mkOption { type = types.str; };
      fg = mkOption { type = types.str; };
      border = mkOption { type = types.str; };
    };
  };

  styleModule = types.submodule {
    options = {
      x = mkOption {
        type = coordModule;
        default = { relative = 1; offset = -48; };
      };
      y = mkOption {
        type = coordModule;
        default = { relative = 0.5; offset = 0; };
      };
      length = mkOption {
        type = coordModule;
        default = { relative = 0.3; offset = 0; };
      };
      thickness = mkOption {
        type = types.int;
        default = 24;
      };
      outline = mkOption {
        type = types.int;
        default = 3;
      };
      border = mkOption {
        type = types.int;
        default = 4;
      };
      padding = mkOption {
        type = types.int;
        default = 3;
      };
      orientation = mkOption {
        type = types.enum [ "vertical" "horizontal" ];
        default = "vertical";
      };
      overflow = mkOption {
        type = types.enum [ "proportional" "hidden" ];
        default = "proportional";
      };
      color = mkOption {
        type = types.attrsOf colorModule;
        default = {
          "normal" = {
            fg = "#ffffff";
            bg = "#000000";
            border = "#ffffff";
          };
          "alt" = {
            fg = "#555555";
            bg = "#000000";
            border = "#555555";
          };
          "overflow" = {
            fg = "#ff0000";
            bg = "#000000";
            border = "#ff0000";
          };
          "altoverflow" = {
            fg = "#550000";
            bg = "#000000";
            border = "#550000";
          };
        };
      };
    };
  };

  defaultStyle = {};
 
  toConfString = with builtins; v: indent: 
    if isInt v then toString v
    else if isFloat v then toString v
    else if isString v then "\"${v}\""
    else if isAttrs v then
      let stringified =
            builtins.concatStringsSep "\n" (mapAttrsToList (name: value: "${fixedWidthString indent " " ""}${name} = ${toConfString value (indent + 2)};") v);
      in "{\n${stringified}\n${fixedWidthString (indent - 2) " " ""}}"
    else abort "unsupported type";

  toConf = with builtins; v:
    concatStringsSep "\n" (mapAttrsToList (name: value: "${name} = ${toConfString value 2};") v);
  
in
{
  options.modules.services.xob = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    styles = mkOption {
      type = types.attrsOf styleModule;
      default = { "default" = defaultStyle; };
    };
  };

  config = mkIf config.modules.services.xob.enable {
    home.packages = with pkgs; [
      xob
      xorg.libX11
      xorg.libXrender
      libconfig
    ];

    xdg.configFile."xob/styles.cfg".text = toConf config.modules.services.xob.styles;
  };
}
