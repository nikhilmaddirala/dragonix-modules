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
  name = "wallpapers";
  description = "Public reusable system capability for wallpapers.";
  packageName = "awww";
})
  moduleArgs
