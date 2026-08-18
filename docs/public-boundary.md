# Public boundary

This repository is a one-way, curated publication surface for reusable
Dragonix behavior.

## Included

- Independently usable Nix modules.
- Generic flake outputs, examples, and checks.
- Documentation and tests that do not depend on private infrastructure.

## Excluded

- Real `hosts/` and `home/` configurations.
- Networking, DNS, Tailscale, SSH, and deployment topology.
- Secret values, secret backends, credential paths, and private service routes.
- Personal agent estates, tenant configuration, media inventories, and
  operational incident material.
- Generated state, snapshots, runs, dumps, caches, and vendored dependencies.
- Third-party material without confirmed redistribution rights.

The private Dragonix repository remains the deployment source of truth. A
future private-to-public export must preserve this boundary and receive an
explicit review before publication.
