{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
    "aarch64-linux"
  ];
  importTree = import ../modules/lib/import-tree.nix { inherit lib; };
  publicProgramModules = importTree ../modules/programs/public;
  publicSystemModules = importTree ../modules/system/public;

  capabilityEnablement =
    namespaceRoot: namespace: path:
    lib.setAttrByPath (
      [
        "dragonix"
        "public"
        "features"
        namespaceRoot
      ]
      ++ namespace
      ++ [ (lib.removeSuffix ".nix" (builtins.baseNameOf path)) ]
    ) { enable = true; };

  allPublicEnablements = lib.foldl' lib.recursiveUpdate { } (
    (map (
      path: capabilityEnablement "programs" [ (builtins.baseNameOf (builtins.dirOf path)) ] path
    ) publicProgramModules)
    ++ (map (capabilityEnablement "system" [ ]) publicSystemModules)
  );

  countEnabled =
    attrs:
    lib.foldl' (
      total: name:
      let
        value = attrs.${name};
      in
      if name == "enable" && value then
        total + 1
      else if lib.isAttrs value then
        total + countEnabled value
      else
        total
    ) 0 (lib.attrNames attrs);

  checkFor =
    system: example:
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

  checkModuleOutput =
    system: module: featurePath: alias:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          module
          {
            home.username = "public";
            home.homeDirectory = "/home/public";
            home.stateVersion = "24.11";
          }
          (lib.setAttrByPath featurePath { enable = true; })
        ];
      };
      feature = lib.getAttrFromPath featurePath home.config;
    in
    pkgs.runCommand "dragonix-public-module-output-${lib.replaceStrings [ "." ] [ "-" ] system}" { } ''
      test "${lib.boolToString feature.enable}" = true
      test "${lib.boolToString (builtins.hasAttr alias home.config.home.shellAliases)}" = true
      touch "$out"
    '';

  checkPrivateConsumer =
    system:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ../examples/private-consumer.nix ];
      };
    in
    pkgs.runCommand "dragonix-public-private-consumer-${lib.replaceStrings [ "." ] [ "-" ] system}" { }
      ''
      test "${lib.boolToString (builtins.hasAttr "dx-programs-ai-telemetry-json" home.config.home.shellAliases)}" = true
        test "${lib.boolToString (builtins.hasAttr "dx-programs-desktop-mpv" home.config.home.shellAliases)}" = true
        test "${lib.boolToString (lib.hasAttrByPath [ "dragonix" "public" "features" ] home.config)}" = true
        test "${lib.boolToString (!(lib.hasAttrByPath [ "dragonix" "features" ] home.config))}" = true
      test "${lib.boolToString (builtins.hasAttr ".config/dragonix-public/programs-ai-telemetry-json.conf" home.config.home.file)}" = true
        touch "$out"
      '';

  checkAllPublicCapabilities =
    system:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ../modules/dragonix
          allPublicEnablements
          {
            home.username = "public";
            home.homeDirectory = "/home/public";
            home.stateVersion = "24.11";
          }
        ];
      };
      expected = builtins.length publicProgramModules + builtins.length publicSystemModules;
      enabled = countEnabled home.config.dragonix.public.features;
    in
    pkgs.runCommand "dragonix-public-all-capabilities-eval" { } ''
      test "${toString enabled}" = "${toString expected}"
      test "${lib.boolToString home.config.dragonix.public.features.programs.ai.codex.enable}" = true
      test "${lib.boolToString home.config.dragonix.public.features.system.audio.enable}" = true
      test "${lib.boolToString (builtins.hasAttr "dx-programs-ai-codex" home.config.home.shellAliases)}" = true
      test "${lib.boolToString (builtins.hasAttr ".config/dragonix-public/programs-ai-codex.conf" home.config.home.file)}" = true
      touch "$out"
    '';

  checkNixos =
    system:
    let
      evaluated = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ../modules/nixos/base.nix
          ../modules/nixos/desktop.nix
          {
            dragonix.features.system.nixos.base.enable = true;
            dragonix.features.system.nixos.desktop.enable = true;
          }
        ];
      };
      pkgs = import inputs.nixpkgs { inherit system; };
    in
    pkgs.runCommand "dragonix-public-nixos-module-eval" { } ''
      test "${lib.boolToString evaluated.config.dragonix.features.system.nixos.base.enable}" = true
      test "${lib.boolToString evaluated.config.dragonix.features.system.nixos.desktop.enable}" = true
      touch "$out"
    '';

  checkDarwin =
    system:
    let
      evaluated = inputs.darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ../modules/darwin/base.nix
          ../modules/darwin/desktop.nix
          {
            dragonix.features.system.darwin.base.enable = true;
            dragonix.features.system.darwin.desktop.enable = true;
          }
        ];
      };
      pkgs = import inputs.nixpkgs { inherit system; };
    in
    pkgs.runCommand "dragonix-public-darwin-module-eval" { } ''
      test "${lib.boolToString evaluated.config.dragonix.features.system.darwin.base.enable}" = true
      test "${lib.boolToString evaluated.config.dragonix.features.system.darwin.desktop.enable}" = true
      touch "$out"
    '';
in
{
  homeManagerModules.default = ../modules/dragonix;
  homeManagerModules.core = ../modules/public;
  homeManagerModules.programs = ../modules/programs/public;
  homeManagerModules.ai = ../modules/programs/public/ai;
  homeManagerModules.desktop = ../modules/programs/public/desktop;
  homeManagerModules.cli = ../modules/programs/cli;
  homeManagerModules.just = ../modules/programs/cli/just;
  homeManagerModules.nix = ../modules/programs/nix;
  homeManagerModules.profiles = ../modules/profiles;
  homeManagerModules.terminal = ../modules/programs/terminal;
  nixosModules.base = ../modules/nixos/base.nix;
  nixosModules.desktop = ../modules/nixos/desktop.nix;
  darwinModules.base = ../modules/darwin/base.nix;
  darwinModules.desktop = ../modules/darwin/desktop.nix;

  checks = lib.genAttrs systems (
    system:
    {
      all-public-capabilities = checkAllPublicCapabilities system;
      developer = checkFor system ../examples/developer.nix;
      minimal = checkFor system ../examples/minimal.nix;
      profiles = checkFor system ../examples/profiles.nix;
      terminal = checkFor system ../examples/terminal.nix;
      private-consumer = checkPrivateConsumer system;
      ai-module = checkModuleOutput system ../modules/programs/public/ai [
        "dragonix"
        "public"
        "features"
        "programs"
        "ai"
        "telemetry-json"
      ] "dx-programs-ai-telemetry-json";
      desktop-module = checkModuleOutput system ../modules/programs/public/desktop [
        "dragonix"
        "public"
        "features"
        "programs"
        "desktop"
        "mpv"
      ] "dx-programs-desktop-mpv";
    }
    // lib.optionalAttrs (system == "x86_64-linux") {
      nixos = checkNixos system;
    }
    // lib.optionalAttrs (system == "aarch64-darwin") {
      darwin = checkDarwin system;
    }
  );
}
