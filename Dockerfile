FROM debian:latest

ENV APP_NAME="Xserve RAID Admin"
WORKDIR /app
COPY start.sh .

# Create container
# 1. Make sure the package repository is up to date
# 2. Install vnc, xvfb in order to create a 'fake' display
# 3. Download and install a working version of Java
# 4. Download RAID Admin
# 5. Setup a password (default is 1234)
# 6. Make the start script executable
RUN apt-get update && \
    apt-get install -y x11vnc xvfb wget && \
    wget -nc https://cdn.azul.com/zulu/bin/zulu7.56.0.11-ca-jdk7.0.352-linux_amd64.deb && \
    apt-get install -y ./zulu7.56.0.11-ca-jdk7.0.352-linux_amd64.deb && \
    rm zulu7.56.0.11-ca-jdk7.0.352-linux_amd64.deb && \
    wget http://download.info.apple.com/Mac_OS_X/061-2942.20070123.xRaTg/RAIDAdmin1.5.1.tar.gz && \
    tar -xf RAIDAdmin1.5.1.tar.gz && \
    rm RAIDAdmin1.5.1.tar.gz && \
    mkdir ~/.vnc && \
    x11vnc -storepasswd 1234 ~/.vnc/passwd && \
    chmod +x start.sh

CMD ["./start.sh"]
