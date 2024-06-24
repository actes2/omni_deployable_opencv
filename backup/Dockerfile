FROM --platform=amd64 ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    unzip \
    rsync \
    libgtk2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY opencv_deps.zip /tmp/deps.zip

RUN unzip /tmp/deps.zip -d / && \
    rsync -a --info=progress2 /dependencies/usr/ /usr && \
    echo '/usr/local/lib/' > /etc/ld.so.conf.d/opencv.conf && \
    ldconfig -v && \
    rm -rf /dependencies && rm -rf tmp/* 

COPY opencv_app /app/opencv_app
COPY template.png /app/template.png

RUN chmod +x /app/opencv_app

CMD ["/app/opencv_app"]
