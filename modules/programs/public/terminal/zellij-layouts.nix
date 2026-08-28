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
  name = "zellij-layouts";
  description = "Public reusable terminal capability for zellij-layouts.";
  packageName = "zellij";
})
  moduleArgs
