{ pkgs }:

{
  allowUnfree = true;
  oraclejdk.accept_license = true;
  input-fonts.acceptLicense = true;
  allowBroken = true;
}
