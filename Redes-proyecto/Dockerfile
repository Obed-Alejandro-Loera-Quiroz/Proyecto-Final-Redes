# Imagen base
FROM ubuntu:latest

# Evitar prompts durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar paquetes, instalar Squid y crear carpeta para blacklist
RUN apt-get update && \
    apt-get install -y squid && \
    rm -f /etc/squid/squid.conf

# Copiar configuración personalizada de squid
COPY squid.conf /etc/squid/

# Copiar carpetas y archivos de blacklist
COPY blacklist.txt /etc/squid/

COPY blocked_sites.acl /etc/squid/

# Exponer el puerto por el que escucha squid (3128 por defecto)
EXPOSE 3128

# Comando para iniciar Squid en primer plano
CMD ["squid", "-N", "-d", "1"]

