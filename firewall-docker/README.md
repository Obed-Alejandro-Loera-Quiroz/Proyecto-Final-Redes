# Firewall Docker Project

## Cómo levantar el entorno

```bash
docker-compose up --build -d
```

## Cómo aplicar las reglas del firewall

```bash
docker exec -it firewall /reglas.sh
```

## Pruebas desde clienteA

```bash
docker exec -it clienteA bash
curl http://192.168.200.1
ftp 192.168.200.1
ping 192.168.200.1
```

## Pruebas desde clienteB

```bash
docker exec -it clienteB bash
curl http://192.168.200.1
ftp 192.168.200.1
ping 192.168.200.1
```

## Ver logs de paquetes bloqueados

```bash
docker logs firewall
```
