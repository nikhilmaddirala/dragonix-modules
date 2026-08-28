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
  name = "browser-runtime";
  description = "Portable Chromium runtime for browser automation and agent tooling.";
  packageName = "chromium";
})
  moduleArgs
