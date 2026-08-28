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
  name = "privacy-settings";
  description = "Public reusable browsing capability for privacy-settings.";
  packageName = "firefox";
})
  moduleArgs
