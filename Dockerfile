FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG OPENCODE_HOME=/home/ubuntu
ARG OPENCODE_WORKDIR=/workspace

ENV OPENCODE_HOME=${OPENCODE_HOME} \
    OPENCODE_WORKDIR=${OPENCODE_WORKDIR} \
    XDG_CONFIG_HOME=${OPENCODE_HOME}/.config \
    XDG_DATA_HOME=${OPENCODE_HOME}/.local/share \
    XDG_STATE_HOME=${OPENCODE_HOME}/.local/state

# 1. Install base tools and Node.js / npm
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    openssh-client \
    sudo \
    nodejs \
    npm \
 && rm -rf /var/lib/apt/lists/* \
 && echo "ubuntu ALL=(ALL) NOPASSWD: /usr/bin/apt-get, /usr/bin/apt" > /etc/sudoers.d/ubuntu \
 && chmod 0440 /etc/sudoers.d/ubuntu

# 2. Install OpenCode AI globally
RUN npm install -g opencode-ai

# 3. Create a dummy xdg-open to suppress browser auto-open errors
RUN echo '#!/bin/sh\nexit 0' > /usr/local/bin/xdg-open \
 && chmod +x /usr/local/bin/xdg-open

# 4. Pre-create XDG standard directories to avoid permission issues for non-root users
RUN mkdir -p "${OPENCODE_HOME}/.config/opencode" \
             "${OPENCODE_HOME}/.local/state" \
             "${OPENCODE_HOME}/.local/share/opencode" \
             "${OPENCODE_HOME}/.ssh" \
 && chown -R ubuntu:ubuntu "${OPENCODE_HOME}"

USER ubuntu
WORKDIR ${OPENCODE_WORKDIR}

# 5. Pre-add GitHub to SSH known hosts to avoid first-connection prompt
RUN ssh-keyscan -T 5 github.com 2>/dev/null >> "${OPENCODE_HOME}/.ssh/known_hosts" || true
