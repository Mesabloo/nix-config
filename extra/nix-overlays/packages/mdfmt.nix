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
    sha256 = "sha256-YQqBvUAp/pd4c71lODOXrQFJacpBy22vx5EHYHTvdYY=";
  };

  meta = with pkgs.lib; {
    description = "Go tool to format Markdown files according to the CommonMark specification";
    license = licenses.mit;
    homepage = "https://github.com/elliotxx/mdfmt";
    maintainers = with maintainers; [ offline ];
    platforms = platforms.unix;
  };
}
