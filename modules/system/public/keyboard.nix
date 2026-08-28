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
  name = "keyboard";
  description = "Public reusable system capability for keyboard.";
  packageName = "xkeyboard_config";
})
  moduleArgs
