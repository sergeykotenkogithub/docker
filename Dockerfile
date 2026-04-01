FROM ghcr.io/openclaw/openclaw:latest

USER root
ENV GATEWAY_PORT=10000
EXPOSE 10000
RUN chmod -R 777 /app || true

USER 1000

# Ограничиваем память до 400МБ (чтобы оставить запас для самой системы)
CMD ["node", "--max-old-space-size=400", "dist/gateway.js", "--host", "0.0.0.0", "--port", "10000", "--allow-unconfigured"]