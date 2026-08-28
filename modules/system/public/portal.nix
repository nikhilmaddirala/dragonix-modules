{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../lib/package-feature.nix {
  namespace = [ ];
  namespaceRoot = "system";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "portal";
  description = "Public reusable system capability for portal.";
  packageName = "xdg-desktop-portal";
})
  moduleArgs
