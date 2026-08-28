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
  name = "karabiner";
  description = "Public reusable system capability for karabiner.";
  packageName = "karabiner-elements";
})
  moduleArgs
