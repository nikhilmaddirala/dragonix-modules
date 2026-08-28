{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "ai" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "node-ai";
  description = "Public reusable ai capability for node-ai.";
  packageName = "nodejs";
})
  moduleArgs
