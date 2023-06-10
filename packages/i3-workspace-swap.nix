{ pkgs
, stdenv ? pkgs.stdenv
}:

with pkgs.python3Packages;
buildPythonApplication rec {
  pname = "i3-workspace-swap";
  version = "1.1.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1apa2qvf5swhkaf0kkfaqxyglbym5h3vgrnb78hq9ni9mspynfkj";
  };

  propagatedBuildInputs = [
    i3ipc
  ];
}
