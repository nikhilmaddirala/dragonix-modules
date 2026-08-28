{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "desktop" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "obsidian";
  description = "Public reusable desktop capability for obsidian.";
  packageName = "obsidian";
})
  moduleArgs
