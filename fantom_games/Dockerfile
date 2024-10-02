FROM ghcr.io/cirruslabs/flutter:3.26.0-0.1.pre

COPY . /app
RUN flutter doctor
WORKDIR /app
RUN flutter pub get

COPY server/server.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]