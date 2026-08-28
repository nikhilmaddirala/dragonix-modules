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

  publicCapabilityMetadataFor =
    system:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.username = "public";
            home.homeDirectory = "/home/public";
            home.stateVersion = "24.11";
          }
        ]
        ++ publicProgramModules
        ++ publicSystemModules;
      };
    in
    home.config.dragonix.public.features.metadata;

  publicCapabilityUsable =
    system: pkgs: metadata: namespaceRoot: namespace: path:
    let
      name = lib.removeSuffix ".nix" (builtins.baseNameOf path);
      capability = lib.getAttrFromPath ([ namespaceRoot ] ++ namespace ++ [ name ]) metadata;
      packageName = capability.packageName;
      systemSupported =
        capability.supportedSystems == null || lib.elem system capability.supportedSystems;
      packageResult =
        if packageName == null then
          {
            success = true;
            value = true;
          }
        else if !systemSupported then
          {
            success = true;
            value = false;
          }
        else
          builtins.tryEval (
            let
              package = lib.attrByPath (lib.splitString "." packageName) null pkgs;
            in
            package != null
            && lib.meta.availableOn pkgs.stdenv.hostPlatform package
            && !lib.elem system (package.meta.badPlatforms or [ ])
            && (builtins.tryEval package.drvPath).success
          );
    in
    packageName == null || (packageResult.success && packageResult.value);

  publicCapabilityModulesFor =
    system:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      metadata = publicCapabilityMetadataFor system;
    in
    {
      programs = lib.filter (
        path:
        publicCapabilityUsable system pkgs metadata "programs" [
          (builtins.baseNameOf (builtins.dirOf path))
        ] path
      ) publicProgramModules;
      system = lib.filter (
        path: publicCapabilityUsable system pkgs metadata "system" [ ] path
      ) publicSystemModules;
    };

  allPublicEnablementsFor =
    system:
    let
      modules = publicCapabilityModulesFor system;
    in
    lib.foldl' lib.recursiveUpdate { } (
      (map (
        path: capabilityEnablement "programs" [ (builtins.baseNameOf (builtins.dirOf path)) ] path
      ) modules.programs)
      ++ (map (capabilityEnablement "system" [ ]) (modules.system))
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
    system: module: featurePath: alias: packageName:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
      package = lib.attrByPath (lib.splitString "." packageName) null pkgs;
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
      test "${lib.boolToString (builtins.elem package home.config.home.packages)}" = true
      touch "$out"
    '';

  checkNativeModules =
    system:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ../modules/programs/public/cli/bat.nix
          ../modules/programs/public/cli/eza.nix
          ../modules/programs/public/ide/helix.nix
          ../modules/programs/public/ide/neovim.nix
          ../modules/system/public/fonts.nix
          {
            home.username = "public";
            home.homeDirectory = "/home/public";
            home.stateVersion = "24.11";
            dragonix.public.features.programs.cli.bat.enable = true;
            dragonix.public.features.programs.cli.eza.enable = true;
            dragonix.public.features.programs.ide.helix.enable = true;
            dragonix.public.features.programs.ide.neovim.enable = true;
            dragonix.public.features.system.fonts.enable = true;
          }
        ];
      };
    in
    pkgs.runCommand "dragonix-public-native-modules-${lib.replaceStrings [ "." ] [ "-" ] system}" { } ''
      test "${lib.boolToString home.config.programs.bat.enable}" = true
      test "${lib.boolToString home.config.programs.eza.enable}" = true
      test "${lib.boolToString home.config.programs.helix.enable}" = true
      test "${lib.boolToString home.config.programs.neovim.enable}" = true
      test "${lib.boolToString home.config.fonts.fontconfig.enable}" = true
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
          test "${lib.boolToString (builtins.elem pkgs.jq home.config.home.packages)}" = true
          test "${lib.boolToString (builtins.elem pkgs.mpv home.config.home.packages)}" = true
          test "${
            lib.boolToString (lib.hasAttrByPath [ "dragonix" "public" "features" ] home.config)
          }" = true
          test "${lib.boolToString (!(lib.hasAttrByPath [ "dragonix" "features" ] home.config))}" = true
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
          (allPublicEnablementsFor system)
          {
            home.username = "public";
            home.homeDirectory = "/home/public";
            home.stateVersion = "24.11";
          }
        ];
      };
      modules = publicCapabilityModulesFor system;
      expected = builtins.length modules.programs + builtins.length modules.system;
      enabled = countEnabled home.config.dragonix.public.features;
      packageCount = builtins.length home.config.home.packages;
    in
    pkgs.runCommand "dragonix-public-all-capabilities-eval" { } ''
      test "${toString enabled}" = "${toString expected}"
      test "${toString packageCount}" -gt 50
      test "${lib.boolToString home.config.dragonix.public.features.programs.ai.codex.enable}" = true
      test "${lib.boolToString home.config.dragonix.public.features.system.audio.enable}" = true
      test "${lib.boolToString (builtins.elem pkgs.jq home.config.home.packages)}" = true
      test "${lib.boolToString (builtins.elem pkgs.mpv home.config.home.packages)}" = true
      test "${lib.boolToString (builtins.hasAttr "dx-programs-ai-codex" home.config.home.shellAliases)}" = true
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

  checkUnsupportedCapability =
    system:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
      evaluation = builtins.tryEval (
        let
          home = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ../modules/dragonix
              {
                home.username = "public";
                home.homeDirectory = "/home/public";
                home.stateVersion = "24.11";
                dragonix.public.features.system.wallpapers.enable = true;
              }
            ];
          };
        in
        home.config.home.packages
      );
    in
    pkgs.runCommand "dragonix-public-unsupported-capability" { } ''
      test "${lib.boolToString (!evaluation.success)}" = true
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
      ] "dx-programs-ai-telemetry-json" "jq";
      desktop-module = checkModuleOutput system ../modules/programs/public/desktop [
        "dragonix"
        "public"
        "features"
        "programs"
        "desktop"
        "mpv"
      ] "dx-programs-desktop-mpv" "mpv";
      native-modules = checkNativeModules system;
    }
    // lib.optionalAttrs (system == "x86_64-linux") {
      nixos = checkNixos system;
    }
    // lib.optionalAttrs (system == "aarch64-darwin") {
      darwin = checkDarwin system;
      unsupported-capability = checkUnsupportedCapability system;
    }
  );
}
