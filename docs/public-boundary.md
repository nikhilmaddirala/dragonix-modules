# Public boundary

This repository is a one-way, curated publication surface for reusable
Dragonix behavior.

## Included

- Independently usable Nix modules.
- Generic flake outputs, examples, and checks.
- Documentation and tests that do not depend on private infrastructure.
- Automated source-boundary checks that look for private identifiers and
  generated state.

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

The tracked `.gitrepo` file is monorepo `git-subrepo` bookkeeping, not public
source. The boundary check validates its metadata shape but excludes it from
the publishable content scan; a standalone export must remove `.gitrepo` before
publication. This preserves the monorepo's local subrepo ownership without
publishing checkout-specific remote metadata.

Run the local check with:

```bash
bash scripts/check-public-boundary.sh
```
