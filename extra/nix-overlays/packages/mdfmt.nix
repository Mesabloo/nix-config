{ pkgs }:

pkgs.buildGoModule rec {
  pname = "mdfmt";
  version = "0.4.2";

  vendorSha256 = "08n4ds6fsli940m4gwvgq7d35chiwypgakkin3caacngn4jgb5d4";
  runVend = true;

  doCheck = false;

  src = pkgs.fetchFromGitHub {
    rev = "v${version}";
    owner = "elliotxx";
    repo = "mdfmt";
    sha256 = "1r12pghnv35yzk7549a35313bvyszy97yx2bpyyfqdrbirk7h1c2";
  };

  meta = with pkgs.lib; {
    description = "Go tool to format Markdown files according to the CommonMark specification";
    license = licenses.mit;
    homepage = "https://github.com/elliotxx/mdfmt";
    maintainers = with maintainers; [ offline ];
    platforms = platforms.unix;
  };
}
