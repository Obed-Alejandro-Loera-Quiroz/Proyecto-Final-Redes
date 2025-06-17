FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y \
    curl \
    ftp \
    iputils-ping \
    telnet \
    openssh-server \
    iptables \
    iproute2 \
    netcat-traditional \
    && rm -rf /var/lib/apt/lists/*

# Crear el directorio necesario para SSH
RUN mkdir /var/run/sshd

# Establecer contraseña de root
RUN echo 'root:rootpassword' | chpasswd

# Exponer el puerto SSH (22)
EXPOSE 22

CMD ["sleep", "infinity"]
