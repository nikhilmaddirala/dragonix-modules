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
  name = "screen-lock";
  description = "Public reusable system capability for screen-lock.";
  packageName = "swaylock";
})
  moduleArgs
