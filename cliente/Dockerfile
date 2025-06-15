# Imagen base
FROM ubuntu:24.04

# Evita prompts interactivos al instalar paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Instala herramientas útiles de red y navegación
RUN apt update && apt install -y \
    dnsutils \
    curl \
    iputils-ping \
    net-tools \
    lynx \
    vim \
    && apt clean

# Comando por defecto al iniciar el contenedor
CMD ["bash"]
