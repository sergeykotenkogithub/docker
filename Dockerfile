FROM ghcr.io/openclaw/openclaw:latest

USER root

# Настройки портов
ENV PORT=10000
ENV GATEWAY_PORT=10000
EXPOSE 10000

# АГРЕССИВНАЯ ОЧИСТКА ПАМЯТИ:
# --max-old-space-size=280: Заставляем Node.js паниковать раньше и чистить память.
# --optimize-for-size: Специальный флаг V8 для экономии ресурсов.
# --gc-interval=100: Чаще запускаем сборщик мусора.
ENV NODE_OPTIONS="--max-old-space-size=280 --optimize-for-size --gc-interval=100"

# Права
RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000
WORKDIR /app

# ЗАПУСК:
CMD ["/bin/sh", "-c", "node -e 'require(\"http\").createServer((req,res)=>res.end(\"ok\")).listen(10000)' & openclaw gateway --port 18789 --allow-unconfigured"]