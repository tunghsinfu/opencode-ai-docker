# OpenCode AI Docker

A Docker Compose environment for running [OpenCode AI](https://opencode.ai) in a containerized development environment.

## What This Does

- Containerizes OpenCode AI with Docker
- Pre-installs Ubuntu, Node.js, npm, and OpenCode AI
- Provides customizable mount paths, ports, and user directories
- Exposes a web interface for using OpenCode

## Project Files

- [Dockerfile](Dockerfile) — Defines the container image and default paths
- [docker-compose.yml](docker-compose.yml) — Defines services, volumes, ports, and startup command
- [.env.example](.env.example) — Example config file; copy to `.env` and customize
- [README.md](README.md) — This file

## Prerequisites

- Docker Engine or Docker Desktop
- WSL2 (if using Docker on Windows)

Verify your setup:

```bash
docker compose version
```

## Quick Start

1. Clone this repository and enter the directory:

```bash
git clone <repo-url>
cd opencode-ai-docker
```

2. (Optional) Create a `.env` file to customize settings:

```bash
cp .env.example .env
```

3. Build the image:

```bash
docker compose build
```

4. Start the container:

```bash
docker compose up -d
```

5. Open your browser to:

```
http://localhost:4096
```

## Configurable Variables

All settings can be customized in `.env`:

| Variable | Default | Description |
|---|---|---|
| `OPENCODE_IMAGE_NAME` | `opencode-ai:latest` | Docker image name |
| `OPENCODE_CONTAINER_NAME` | `opencode_container` | Docker container name |
| `OPENCODE_CONFIG_HOST_PATH` | `./data/config` | Host path for OpenCode config |
| `OPENCODE_DATA_HOST_PATH` | `./data/local` | Host path for persistent data |
| `OPENCODE_WORKSPACE_HOST_PATH` | `./workspace` | Host path for workspace files |
| `OPENCODE_HOME` | `/home/ubuntu` | Container home directory |
| `OPENCODE_WORKDIR` | `/workspace` | Container working directory |
| `OPENCODE_PORT` | `4096` | Web UI port |
| `OPENCODE_HOST` | `0.0.0.0` | Web UI bind address |
| `OPENCODE_SERVER_PASSWORD` | `opencode` | Password to secure the web UI (change in production) |
| `OPENCODE_SERVER_USERNAME` | `opencode` | Basic auth username (default: opencode) |

## Default Behavior

If no `.env` overrides are provided, the defaults are used automatically:

- Workspace: `./workspace`
- Config data: `./data/config`
- Persistent data: `./data/local`
- Port: `4096`

## Common Commands

```bash
# Start services
docker compose up -d

# View logs
docker compose logs -f

# Stop services
docker compose down

# Rebuild from scratch
docker compose build --no-cache

# Enter the container
docker compose exec opencode-ai bash
```

## Troubleshooting

If the web interface is not accessible:

- Check container status: `docker compose ps`
- View logs: `docker compose logs`
- Verify the port is not already in use
- Adjust `OPENCODE_PORT` in `.env` if needed
