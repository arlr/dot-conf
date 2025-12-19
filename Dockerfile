FROM ubuntu:rolling

# Install requirements
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    git \
    openssl

RUN useradd -m devuser -p $(openssl passwd -1 12) && \
    usermod -aG sudo devuser
WORKDIR /home/devuser
USER devuser

# Copy current WP directory to container
RUN mkdir /home/devuser/dot-conf
COPY .  /home/devuser/dot-conf
WORKDIR /home/devuser/dot-conf


#RUN chmod +x SystemSetup.sh
CMD ["/bin/bash"]