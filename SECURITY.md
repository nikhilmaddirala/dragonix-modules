# Security policy

Please report security vulnerabilities privately through [GitHub Security
Advisories](https://github.com/nikhilmaddirala/dragonix-modules/security/advisories/new).
Do not put secrets, private infrastructure details, or vulnerability reports in
public issues.

The public boundary check also rejects known private host identifiers,
credential-shaped source values, generated state, and an incomplete module
manifest. Reviewers should inspect the manifest and provenance document when
adding a module or third-party asset.
