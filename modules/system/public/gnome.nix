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
  name = "gnome";
  description = "Public reusable system capability for gnome.";
  packageName = "gnome-shell";
})
  moduleArgs
