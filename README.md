# OpenCode AI Docker 開發環境

這個專案提供一個可直接啟動的 Docker Compose 環境，讓你在容器中使用 OpenCode AI，並把需要自行調整的設定抽象成使用者可配置的項目。

## 這個專案做什麼

- 使用 Docker 容器化 OpenCode AI
- 預先安裝 Ubuntu、Node.js、npm 與 OpenCode AI
- 將工作目錄、設定檔與持久化資料改成可由使用者自行調整的設定
- 可透過 Web 介面使用 OpenCode

## 專案檔案

- [Dockerfile](Dockerfile)：定義容器映像內容與預設路徑
- [docker-compose.yml](docker-compose.yml)：定義服務、掛載路徑、埠號與啟動命令
- [README.md](README.md)：使用說明
- [.env.example](.env.example)：可直接複製成 .env 的範例設定檔

## 前置需求

請先確認你的主機已安裝：

- Docker Engine 或 Docker Desktop
- WSL2（如果你是在 Windows 上使用 Docker）

可先確認 Docker 是否可用：

```bash
docker compose version
```

## 快速開始

1. 進入專案資料夾

```bash
cd /mnt/d/OneDrive - Acer/WSL/docker/opencode
```

2. 建立環境設定檔（可選）

如果你想調整掛載路徑、埠號或容器名稱，請先複製範例檔：

```bash
cp .env.example .env
```

之後依照你的需求修改 [.env](.env) 內容。

3. 建立映像檔

```bash
docker compose build
```

4. 啟動容器

```bash
docker compose up -d
```

5. 開啟瀏覽器

請前往：

```text
http://localhost:4096
```

## 可由使用者設定的項目

這次重構後，以下設定可以由使用者自行調整：

- 持久化資料路徑：
  - `OPENCODE_CONFIG_HOST_PATH`
  - `OPENCODE_DATA_HOST_PATH`
  - `OPENCODE_WORKSPACE_HOST_PATH`
- 容器內工作目錄與使用者家目錄：
  - `OPENCODE_WORKDIR`
  - `OPENCODE_HOME`
- Web 介面埠號與主機位址：
  - `OPENCODE_PORT`
  - `OPENCODE_HOST`
- 容器名稱與映像名稱：
  - `OPENCODE_CONTAINER_NAME`
  - `OPENCODE_IMAGE_NAME`

你可以在 [.env](.env) 中直接覆寫這些值。

## 預設行為

若沒有提供任何覆寫設定，專案會使用下列預設值：

- 工作目錄：`./workspace`
- 設定資料：`./data/config`
- 持久化資料：`./data/local`
- Web 介面埠號：`4096`

這樣可以避免把路徑寫死在專案中，讓你在不同機器或不同專案資料夾時都比較方便移植。

## 常用指令

啟動服務：

```bash
docker compose up -d
```

查看日誌：

```bash
docker compose logs -f
```

停止服務：

```bash
docker compose down
```

重新建置：

```bash
docker compose build --no-cache
```

進入容器終端：

```bash
docker compose exec opencode-ai bash
```

## 疑難排解

如果無法正常開啟 Web 介面，請先確認：

- 容器是否成功啟動：

```bash
docker compose ps
```

- 是否有錯誤訊息：

```bash
docker compose logs
```

- 連接埠是否被其他程式占用

如果你需要調整埠號，請修改 [.env](.env) 中的 `OPENCODE_PORT`，並確保 [docker-compose.yml](docker-compose.yml) 也會套用到新的設定。