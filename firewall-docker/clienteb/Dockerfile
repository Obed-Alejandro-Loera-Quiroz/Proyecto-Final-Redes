FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y curl ftp iputils-ping telnet && \ 
    rm -rf /var/lib/apt/lists/*  

CMD ["sleep", "infinity"]
