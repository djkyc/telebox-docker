#!/bin/sh
set -e

echo "[entrypoint] TeleBox container starting..."

# 确保目录存在（即使挂了卷也安全）
mkdir -p /app/data /app/my_session

# 如果 .env 不存在，则根据环境变量生成
if [ ! -f /app/.env ]; then
  echo "[entrypoint] Generating /app/.env from environment variables"

  {
    echo "API_ID=${API_ID}"
    echo "API_HASH=${API_HASH}"
    echo "BOT_TOKEN=${BOT_TOKEN}"
    echo "NODE_ENV=${NODE_ENV:-production}"
  } > /app/.env
else
  echo "[entrypoint] Using existing /app/.env"
fi

echo "[entrypoint] Starting TeleBox..."
exec npm start
