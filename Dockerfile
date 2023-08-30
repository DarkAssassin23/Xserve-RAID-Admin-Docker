FROM jlesage/baseimage-gui:debian-11

ENV APP_NAME="Xserve RAID Admin"
WORKDIR /app
COPY start.sh .

# Make sure the package repository is up to date
# Install vnc, xvfb in order to create a 'fake' display
# Setup a password (default is 1234)
# Make the start script executable
RUN apt-get update && \
    apt-get install -y x11vnc xvfb wget && \
    #wget -nc https://cdn.azul.com/zulu/bin/zulu8.68.0.21-ca-jdk8.0.362-linux_amd64.deb && \
    #apt-get install -y ./zulu8.68.0.21-ca-jdk8.0.362-linux_amd64.deb && \
    wget -nc https://cdn.azul.com/zulu/bin/zulu7.56.0.11-ca-jdk7.0.352-linux_amd64.deb && \
    apt-get install -y ./zulu7.56.0.11-ca-jdk7.0.352-linux_amd64.deb && \
    wget http://download.info.apple.com/Mac_OS_X/061-2942.20070123.xRaTg/RAIDAdmin1.5.1.tar.gz && \
    tar -xf RAIDAdmin1.5.1.tar.gz && \
    rm RAIDAdmin1.5.1.tar.gz && \
    mkdir ~/.vnc && \
    x11vnc -storepasswd 1234 ~/.vnc/passwd && \
    chmod +x start.sh

CMD ["./start.sh"]