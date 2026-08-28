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
  name = "browser-devtools";
  description = "Public reusable browsing capability for browser-devtools.";
  packageName = "chromium";
})
  moduleArgs
