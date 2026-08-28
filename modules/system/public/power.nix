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
  name = "power";
  description = "Public reusable system capability for power.";
  packageName = "upower";
})
  moduleArgs
