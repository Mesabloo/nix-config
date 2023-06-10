{ pkgs }:

with pkgs.python38Packages;

let
  python-lsp-jsonrpc =
    buildPythonPackage rec {
      pname = "python-lsp-jsonrpc";
      version = "1.0.0";

      src = fetchPypi {
        inherit pname version;
        sha256 = "7bec170733db628d3506ea3a5288ff76aa33c70215ed223abdb0d95e957660bd";
      };

      propagatedBuildInputs = [
        ujson
      ];

      doCheck = false;
    };

in
buildPythonApplication rec {
  pname = "python-lsp-server";
  version = "1.2.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "8c3e8ff5ff076f1aed8db5f14041e76d19ebd09ba1867e3f5f2f6740423ce0e3";
  };

  propagatedBuildInputs = with pkgs; [
    python-lsp-jsonrpc
    pluggy
    ujson
    jedi
    setuptools
  ];

  doCheck = false;
}
