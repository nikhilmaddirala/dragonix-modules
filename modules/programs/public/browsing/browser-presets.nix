{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "browsing" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "browser-presets";
  description = "Public reusable browsing capability for browser-presets.";
  packageName = "chromium";
})
  moduleArgs
