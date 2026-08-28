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
  name = "lua-for-hammerspoon";
  description = "Lua runtime for authoring Hammerspoon configuration; Hammerspoon itself is not included.";
  packageName = "lua";
})
  moduleArgs
