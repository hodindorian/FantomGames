FROM ghcr.io/cirruslabs/flutter:3.13.4
COPY . .
WORKDIR .
RUN flutter pub get
CMD ["flutter", "run","-d","chrome"]
