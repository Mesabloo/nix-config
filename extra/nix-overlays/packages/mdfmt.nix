{ pkgs }:

pkgs.buildGoModule rec {
  pname = "mdfmt";
  version = "0.4.2";

  vendorSha256 = "/9NEcnfRjhxLaM3SoCkbVJcLzQqgie8/Zq18kWsEto8=";
  proxyVendor = true;

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
