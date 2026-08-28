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
  name = "shell-agent";
  description = "Public reusable ai capability for shell-agent.";
  packageName = "bash";
})
  moduleArgs
