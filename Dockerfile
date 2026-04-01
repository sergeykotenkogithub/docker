FROM ghcr.io/openclaw/openclaw:latest
USER 1000
ENV GATEWAY_PORT=7860
# В некоторых образах достаточно просто запустить бинарник
CMD ["openclaw", "gateway", "--host", "0.0.0.0", "--port", "10000", "--allow-unconfigured"]