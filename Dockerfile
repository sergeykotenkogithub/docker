FROM ghcr.io/openclaw/openclaw:latest

USER root

# Стандартные порты для Render
ENV PORT=10000
ENV GATEWAY_PORT=10000
EXPOSE 10000

# Даем права на домашнюю директорию
RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000

# ФИНАЛЬНЫЙ СКРИПТ ЗАПУСКА:
# 1. Мы находим путь к gateway.js динамически (через $(find ...))
# 2. Запускаем его через node с ограничением памяти 350MB
# 3. Передаем все нужные флаги
CMD ["/bin/sh", "-c", "node --max-old-space-size=350 $(find / -name gateway.js | head -n 1) --host 0.0.0.0 --port 10000 --allow-unconfigured"]