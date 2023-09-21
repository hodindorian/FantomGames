FROM ghcr.io/cirruslabs/flutter:3.13.4
COPY . ./fantom_games
WORKDIR ./fantom_games
RUN flutter pub get
RUN flutter build web --no-tree-shake-icons
CMD [ "flutter", "run", "-d", "web-server", "--web-port=80", "--release" ]