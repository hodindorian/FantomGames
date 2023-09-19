FROM ghcr.io/cirruslabs/flutter:3.13.4
COPY . /var/www/html
WORKDIR /var/www/html
RUN flutter pub get
RUN flutter build web
