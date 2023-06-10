{ pkgs }:

pkgs.python38Packages.buildPythonApplication rec {
  pname = "key-mon";
  version = "1.16";

  src = pkgs.fetchFromGitHub {
    owner = "scottkirkwood";
    repo = pname;
    rev = "3785370d09a1a3168e2578c04857796b6c00fb9a";
    sha256 = "1pddwklmahnakcdxsawk5nyw6vwc5vmann89znsgi6b8q431xl5h";
  };

  nativeBuildInputs = with pkgs; [
    gobject-introspection
    wrapGAppsHook
  ];

  buildInputs = with pkgs; [
    gtk3
  ];

  propagatedBuildInputs = with pkgs.python38Packages; [
    pygobject3
    xlib
  ];

  strictDeps = false;
  doCheck = false;
}
