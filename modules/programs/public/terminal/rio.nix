{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "terminal" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "rio";
  description = "Public reusable terminal capability for rio.";
  packageName = "rio";
})
  moduleArgs
