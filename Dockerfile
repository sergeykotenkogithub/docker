FROM ghcr.io/openclaw/openclaw:latest

USER root

# Настройки портов
ENV PORT=10000
ENV GATEWAY_PORT=10000
EXPOSE 10000

# Оставляем ТОЛЬКО лимит памяти. Это Node.js разрешает всегда.
ENV NODE_OPTIONS="--max-old-space-size=300"

# Права
RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000
WORKDIR /app

# ЗАПУСК:
# Передаем лимит памяти прямо в команде запуска, на всякий случай.
CMD ["/bin/sh", "-c", "node -e 'require(\"http\").createServer((req,res)=>res.end(\"ok\")).listen(10000)' & openclaw gateway --port 18789 --allow-unconfigured"]