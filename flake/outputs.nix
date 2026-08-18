{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
    "aarch64-linux"
  ];

  checkFor = system:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ../modules/programs/cli/just
          {
            home.username = "public";
            home.homeDirectory = "/home/public";
            home.stateVersion = "24.11";
            dragonix.features.programs.cli.just.enable = true;
          }
        ];
      };
    in
    home.activationPackage;
in
{
  homeManagerModules.just = ../modules/programs/cli/just;

  checks = lib.genAttrs systems (system: {
    just = checkFor system;
  });
}
