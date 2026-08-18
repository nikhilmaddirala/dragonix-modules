{ config, lib, pkgs, ... }:
let
  cfg = config.dragonix.features.programs.cli.development;
in
{
  options.dragonix.features.programs.cli.development = {
    enable = lib.mkEnableOption "developer-oriented command-line tools";

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Additional packages to install with the public developer feature.";
    };

    gitDelta.enable = lib.mkEnableOption "delta integration for Git" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      just
      nixfmt
      shellcheck
      shfmt
    ] ++ cfg.extraPackages;

    programs.delta = {
      enable = cfg.gitDelta.enable;
      enableGitIntegration = cfg.gitDelta.enable;
    };
  };
}
