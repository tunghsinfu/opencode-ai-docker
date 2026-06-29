FROM --platform=linux/amd64 ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG OPENCODE_HOME=/home/ubuntu
ARG OPENCODE_WORKDIR=/workspace

ENV OPENCODE_HOME=${OPENCODE_HOME} \
    OPENCODE_WORKDIR=${OPENCODE_WORKDIR} \
    XDG_CONFIG_HOME=${OPENCODE_HOME}/.config \
    XDG_DATA_HOME=${OPENCODE_HOME}/.local/share \
    XDG_STATE_HOME=${OPENCODE_HOME}/.local/state

# 1. 安裝基礎工具與 Node.js / npm
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

# 2. 全域安裝 OpenCode AI
RUN npm install -g opencode-ai

# 3. 建立一個假的 xdg-open 封印自動開啟瀏覽器的錯誤
RUN echo '#!/bin/sh\nexit 0' > /usr/local/bin/xdg-open \
 && chmod +x /usr/local/bin/xdg-open

# 4. 事先建立 XDG 標準目錄，避免非 root 使用者在啟動時遇到權限問題
RUN mkdir -p "${OPENCODE_HOME}/.config/opencode" \
             "${OPENCODE_HOME}/.local/state" \
             "${OPENCODE_HOME}/.local/share/opencode" \
             "${OPENCODE_HOME}/.ssh" \
 && chown -R ubuntu:ubuntu "${OPENCODE_HOME}"

USER ubuntu
WORKDIR ${OPENCODE_WORKDIR}

# 5. 預先將 GitHub 加入 SSH 信任主機清單，避免首次連線時卡住
RUN ssh-keyscan -T 5 github.com 2>/dev/null >> "${OPENCODE_HOME}/.ssh/known_hosts" || true