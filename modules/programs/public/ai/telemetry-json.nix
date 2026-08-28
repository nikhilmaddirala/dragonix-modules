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
  name = "telemetry-json";
  description = "Portable JSON tooling for inspecting telemetry data.";
  packageName = "jq";
})
  moduleArgs
