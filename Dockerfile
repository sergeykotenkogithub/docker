FROM ghcr.io/openclaw/openclaw:latest

USER root

# Стандартные порты
ENV PORT=10000
ENV GATEWAY_PORT=10000
EXPOSE 10000

# Даем права только на нужную папку, чтобы не нагружать файловую систему
RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000
WORKDIR /app

# ФИНАЛЬНЫЙ ТРЮК:
# 1. Снижаем лимит памяти до 350МБ (чтобы точно влезть в 512МБ хостинга)
# 2. Используем 'node' напрямую для запуска
# 3. Добавляем флаг --expose-gc (помогает Node.js лучше чистить мусор)
CMD ["node", "--max-old-space-size=350", "--expose-gc", "dist/gateway.js", "--host", "0.0.0.0", "--port", "10000", "--allow-unconfigured"]