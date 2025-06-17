#!/bin/bash

# Limpia reglas
iptables -F
iptables -X

# 1. Bloquear puerto 80 (HTTP) hacia el firewall desde clienteA
#iptables -A INPUT -p tcp --dport 80 -s 192.168.200.10 -j REJECT --reject-with tcp-reset

# 2. Bloquear puerto 21 (FTP) hacia el firewall desde clienteB
#iptables -A INPUT -p tcp --dport 21 -s 192.168.200.20 -j REJECT --reject-with tcp-reset

# 3. Bloquear tráfico saliente del firewall hacia 192.168.200.10 - 192.168.200.100
#iptables -A OUTPUT -d 192.168.200.10/31 -j DROP
#iptables -A OUTPUT -d 192.168.200.12/30 -j DROP
#iptables -A OUTPUT -d 192.168.200.16/28 -j DROP
#iptables -A OUTPUT -d 192.168.200.32/27 -j DROP
#iptables -A OUTPUT -d 192.168.200.64/26 -j DROP

#iptables -A INPUT -d 192.168.200.10/31 -j DROP
#iptables -A INPUT -d 192.168.200.12/30 -j DROP
#iptables -A INPUT -d 192.168.200.16/28 -j DROP
#iptables -A INPUT -d 192.168.200.32/27 -j DROP
#iptables -A INPUT -d 192.168.200.64/26 -j DROP

# 4. Bloquear respuestas ICMP echo-reply
#iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP
#iptables -A INPUT -p icmp --icmp-type echo-reply -j DROP

# 6. Limitar el número de conexiones simultáneas por IP a un máximo de 20
#iptables -A INPUT -p tcp --syn -m connlimit --connlimit-above 20 -j REJECT --reject-with tcp-reset

# 7. Bloquear todo tráfico saliente a puerto 443 desde estación de prueba (clienteA por ejemplo)
#iptables -I OUTPUT -s 192.168.200.2 -p tcp --dport 443 -j REJECT
#iptables -I INPUT -s 192.168.200.2 -p tcp --dport 443 -j REJECT

# 8. Permitir solo SSH (puerto 22) desde una IP autorizada (clienteA por ejemplo)
#iptables -A INPUT -p tcp --dport 22 ! -s 192.168.200.10 -j REJECT --reject-with tcp-reset

