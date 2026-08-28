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
  name = "system-extensions";
  description = "Public reusable system capability for system-extensions.";
  packageName = "xdg-utils";
})
  moduleArgs
