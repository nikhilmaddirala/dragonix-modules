{ config, lib, pkgs, ... }:
let
  cfg = config.dragonix.features.programs.nix.quality;
in
{
  options.dragonix.features.programs.nix.quality = {
    enable = lib.mkEnableOption "Nix and shell quality tools";

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Additional quality tools to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt
      shellcheck
      shfmt
    ] ++ cfg.extraPackages;
  };
}
