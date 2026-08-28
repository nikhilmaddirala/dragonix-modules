{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "ide" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "tree-sitter";
  description = "Public reusable ide capability for tree-sitter.";
  packageName = "tree-sitter";
})
  moduleArgs
