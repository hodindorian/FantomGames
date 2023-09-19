FROM ghcr.io/cirruslabs/flutter:3.13.4
COPY . /var/www/html
WORKDIR /var/www/html
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb
RUN flutter run -d web --web-port 80
