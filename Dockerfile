FROM --platform=amd64 ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

COPY dependencies/usr /usr
COPY opencv_app /app/opencv_app
COPY template.png /app/template.png

RUN apt-get update && apt-get install -y \ 
    rsync \
    libgtk2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN echo '/usr/local/lib/' > /etc/ld.so.conf.d/opencv.conf && \
    ldconfig -v

RUN chmod +x /app/opencv_app

CMD ["/app/opencv_app"]
