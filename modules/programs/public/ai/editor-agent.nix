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
  name = "editor-agent";
  description = "Public reusable ai capability for editor-agent.";
  packageName = "neovim";
})
  moduleArgs
