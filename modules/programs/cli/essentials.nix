{ config, lib, pkgs, ... }:
let
  cfg = config.dragonix.features.programs.cli.essentials;
in
{
  options.dragonix.features.programs.cli.essentials = {
    enable = lib.mkEnableOption "essential command-line tools";

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Additional packages to install with the public CLI baseline.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
      git
      jq
      ripgrep
    ] ++ cfg.extraPackages;

    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        init.defaultBranch = "main";
        pull.ff = "only";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };
}
