{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "browsing" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "firefox";
  description = "Public reusable browsing capability for firefox.";
  packageName = "firefox";
})
  moduleArgs
