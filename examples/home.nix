{ ... }:
{
  imports = [
    ../modules/programs/cli/just
  ];

  home.username = "public";
  home.homeDirectory = "/home/public";
  home.stateVersion = "24.11";

  dragonix.features.programs.cli.just.enable = true;
}
