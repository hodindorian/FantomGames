FROM ubuntu:20.04
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y curl git wget psmisc unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 clang cmake pkg-config libgtk-3-dev xz-utils
RUN wget -qO /usr/local/bin/ninja.gz https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip
RUN gunzip /usr/local/bin/ninja.gz
RUN chmod a+x /usr/local/bin/ninja
RUN apt-get clean

COPY . /app
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.5-stable.tar.xz
RUN mkdir /usr/local/flutter
RUN tar -xf flutter_linux_3.13.5-stable.tar.xz -C /usr/local/
RUN git config --global --add safe.directory /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter channel master
RUN flutter config --enable-web
RUN flutter doctor
WORKDIR /app
RUN flutter build web

RUN ["chmod", "+x", "/app/server/server.sh"]
ENTRYPOINT [ "/app/server/server.sh"]