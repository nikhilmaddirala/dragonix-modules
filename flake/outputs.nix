{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
    "aarch64-linux"
  ];

  checkFor = system: example:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          example
        ];
      };
    in
    home.activationPackage;
in
{
  homeManagerModules.default = ../modules/dragonix;
  homeManagerModules.cli = ../modules/programs/cli;
  homeManagerModules.just = ../modules/programs/cli/just;
  homeManagerModules.nix = ../modules/programs/nix;
  homeManagerModules.profiles = ../modules/profiles;
  homeManagerModules.terminal = ../modules/programs/terminal;

  checks = lib.genAttrs systems (system: {
    developer = checkFor system ../examples/developer.nix;
    minimal = checkFor system ../examples/minimal.nix;
    terminal = checkFor system ../examples/terminal.nix;
  });
}
