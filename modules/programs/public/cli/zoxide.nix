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
  name = "zoxide";
  description = "Directory-jumping history with shell integration.";
  packageName = "zoxide";
  nativeConfig = {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
})
  moduleArgs
