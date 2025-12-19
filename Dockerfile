FROM ubuntu:rolling

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    git \
    openssl

RUN useradd -m devuser -p $(openssl passwd -1 devpassword) && \
    usermod -aG sudo devuser
WORKDIR /home/devuser
USER devuser

# Install requirements

RUN git clone https://github.com/arlr/dot-conf.git
WORKDIR /home/devuser/dot-conf


RUN chmod +x SystemSetup.sh
CMD ["/bin/bash", "./SystemSetup.sh", "-l"]