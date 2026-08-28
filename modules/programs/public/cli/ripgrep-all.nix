{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "cli" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "ripgrep-all";
  description = "Public reusable cli capability for ripgrep-all.";
  packageName = "ripgrep-all";
})
  moduleArgs
