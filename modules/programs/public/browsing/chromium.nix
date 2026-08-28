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
  name = "chromium";
  description = "Public reusable browsing capability for chromium.";
  packageName = "chromium";
})
  moduleArgs
