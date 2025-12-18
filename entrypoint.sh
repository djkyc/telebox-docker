#!/bin/sh
set -e

echo "[entrypoint] TeleBox container starting..."

# 确保必要目录存在
mkdir -p /app/data /app/my_session

ENV_FILE="/app/.env"

# 如果 .env 不存在，则从环境变量生成
if [ ! -f "$ENV_FILE" ]; then
  echo "[entrypoint] Generating $ENV_FILE from environment variables"

  {
    echo "API_ID=${API_ID}"
    echo "API_HASH=${API_HASH}"
    echo "BOT_TOKEN=${BOT_TOKEN}"
    echo "NODE_ENV=${NODE_ENV:-production}"
  } > "$ENV_FILE"
else
  echo "[entrypoint] Using existing $ENV_FILE"
fi

# 🔥 关键：加载 .env 到当前 shell 环境
echo "[entrypoint] Loading environment variables from $ENV_FILE"
set -a
. "$ENV_FILE"
set +a

echo "[entrypoint] Starting TeleBox..."
exec npm start
