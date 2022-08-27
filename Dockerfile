FROM cloudron/base:3.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea

RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless && \
    rm -rf /var/cache/apt /var/lib/apt/lists

RUN mkdir -p /app/code /app/pkg

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

ARG VERSION=2.6.3

RUN curl -SLf "https://github.com/hectorqin/reader/releases/download/v${VERSION}/reader-pro-${VERSION}.jar" > /app/code/reader.jar && \
    chown -R cloudron:cloudron /app/code

ADD env start.sh /app/pkg/

WORKDIR /app/code

EXPOSE 8080

CMD [ "/app/pkg/start.sh" ]
