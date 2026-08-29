# Private Dragonix consumer contract

The private Dragonix flake consumes the public core while both repositories are
maintained in the combined checkout. Its input is the sibling subtree and its
module list includes the collision-free `core` output:

```nix
inputs.dragonix-public.url = "path:../dragonix-public";

homeManagerModules = [
  inputs.dragonix-public.homeManagerModules.core
  ./private-modules.nix
];
```

After explicit standalone publication, the same consumer changes only the
input URL to the published repository; the module output remains `core`:

```nix
inputs.dragonix-public.url = "github:nikhilmaddirala/dragonix-modules";
```

The public module owns only sanitized, opt-in options under
`dragonix.public.features`. Private host composition, secrets, host-specific
paths, and runtime topology remain in the private consumer. The two surfaces
therefore compose into one runtime without moving private configuration into
this repository.

The private checkout is the combined runtime configuration. Standalone
publication is a separate, approval-gated delivery step; this implementation
does not create or push that repository.
