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
  name = "aerospace";
  description = "Public reusable system capability for aerospace.";
  packageName = "aerospace";
  supportedSystems = [
    "aarch64-darwin"
    "x86_64-darwin"
  ];
})
  moduleArgs
