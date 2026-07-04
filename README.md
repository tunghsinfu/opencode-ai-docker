# OpenCode AI Docker

This repository provides a Docker Compose setup for running [OpenCode AI](https://opencode.ai) in a container with persistent local storage for configuration, data, and workspace files.

## What this setup includes

- A containerized OpenCode AI web UI
- A Ubuntu-based image with Node.js, npm, and OpenCode AI preinstalled
- Persistent bind mounts for:
  - OpenCode config
  - OpenCode local data
  - your project workspace
- Easy configuration through environment variables

## Repository files

- [Dockerfile](Dockerfile) — Builds the base image and prepares the runtime environment
- [docker-compose.yml](docker-compose.yml) — Defines the service, ports, volumes, and startup command
- [.env](.env) — Example runtime configuration used by Docker Compose
- [README.md](README.md) — This guide

## Prerequisites

Make sure you have one of the following installed:

- Docker Desktop, or
- Docker Engine with the Compose plugin

Verify your installation:

```bash
docker compose version
```

## Quick start

1. Clone the repository and change into it:

```bash
git clone <repo-url>
cd opencode-ai-docker
```

2. Review the environment file and adjust values if needed:

```bash
nano .env
```

The included [.env](.env) file already sets sensible defaults for the container name, bind host, port, and persistent storage paths.

3. Build and start the container:

```bash
docker compose up -d --build
```

4. Open the web interface in your browser:

```text
http://127.0.0.1:4096
```

If you changed the port or host binding in [.env](.env), use those values instead.

## Configuration

The following variables can be customized in [.env](.env):

| Variable | Default | Description |
|---|---|---|
| `OPENCODE_IMAGE_NAME` | `opencode-ai:latest` | Image name for the built container |
| `OPENCODE_CONTAINER_NAME` | `opencode_container` | Container name |
| `OPENCODE_SERVER_HOST` | `127.0.0.1` | Host interface bound by Docker |
| `OPENCODE_SERVER_PORT` | `4096` | Port exposed for the web UI |
| `OPENCODE_SERVER_USERNAME` | `opencode` | Username used by the app |
| `OPENCODE_SERVER_PASSWORD` | `opencode` | Password used by the app |
| `OPENCODE_CONFIG_HOST_PATH` | `./data/config` | Host path for config storage |
| `OPENCODE_DATA_HOST_PATH` | `./data/local` | Host path for local data storage |
| `OPENCODE_WORKSPACE_HOST_PATH` | `./data/workspace` | Host path mounted to `/workspace` |

## Common commands

```bash
# Start the container
docker compose up -d

# Rebuild after changing Dockerfile or compose settings
docker compose up -d --build

# View logs
docker compose logs -f

# Stop the container
docker compose down

# Open a shell inside the running container
docker compose exec opencode-ai bash
```

## Notes

- The container starts OpenCode with:

```bash
opencode web --port 4096 --hostname 0.0.0.0
```

- The workspace is mounted at `/workspace`, which is also the container working directory.
- The bind mounts keep your configuration and project files available across container restarts.

## Troubleshooting

If the web UI is not reachable:

- Check container status with `docker compose ps`
- Review logs with `docker compose logs`
- Make sure the configured port is not already in use
- Confirm that the host bind address in [.env](.env) matches your access method
