# Global Claude Instructions

## Code comments

Don't add obvious comments that restate what the code does. Only comment to explain non-obvious things: why, edge cases, tricky logic, gotchas.

## Dev environment

I usually don't have a local dev environment (no local venv, linters, or test runners installed). If a project provides a Docker Compose dev setup, run commands through it rather than directly on the host. Find the right invocation for the repo you're in before defaulting to a generic one — check `docker-compose.yml`, the Makefile, and the README/CONTRIBUTING for the documented dev service and entrypoint. Many repos expose a project-specific entrypoint that's cleaner than dropping into a shell — e.g. `docker compose run --rm --entrypoint pipe-research dev <subcommand> <args>` on pipe-research (and similar `--entrypoint <tool> dev ...` patterns in other pipe-* repos). Fall back to a generic shell like `docker compose run --rm --entrypoint /bin/bash <service> -c "<cmd>"` only when no project-specific command fits, and to running directly on the host only when no compose dev environment exists.
