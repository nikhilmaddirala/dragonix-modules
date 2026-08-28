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
  name = "terminal-shell-integration";
  description = "Public reusable terminal capability for terminal-shell-integration.";
  packageName = "bash";
})
  moduleArgs
