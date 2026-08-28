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
  name = "system-monitoring";
  description = "Public reusable system capability for system-monitoring.";
  packageName = "procps";
})
  moduleArgs
