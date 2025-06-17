# Proyecto-Final-Redes

Proyecto Final de Redes de Computadores, donde se implementó proxy, host virtuales, DNS e Iptables

### Requisitos para el funcionamiento del proyecto 

#### - Instalación de Docker

En cualquier navegador disponible en el dispositivo buscar docker, ingrear a la primera pagina disponible e ir al aparatdo de descarga, en ese apartado hay varias opciones de instalacion, elige la mas apropiada segun tu PC. En Docker es recomendable crear una cuenta para el optimo funcionamiento 

[Instalacion de Docker](https://www.docker.com/)

#### - Instalar WSL mediante los siguientes comandos en la terminal
```bash
wsl --install
```
Esto instalará WSL, la última versión del kernel de Linux y Ubuntu automáticamente (en Windows 11). Después reiniciar la PC o laptop y por último, configure WSL 2 como predeterminado con el siguiente comando:
```bash
wsl --set-default-version 2
```
#### - Instalar Ubuntu 

Abre Microsoft Store, busca Ubuntu, elige la versión que mas gustes e instala o en algunos casos aparece la opción de obtener, abre el menú inicio y busca Ubuntu. Al abrirlo por primera vez, se instalará y te pedirá el nombre de usuario y la contraseña 

#### - Instalar el navegador FireFox

En cualquier navegador disponible buscar FireFox e instala según tu sistema operativo

[Instalacion de Firefox](https://mozilla-firefox.softonic.com/)

No asignes FireFox como navegador predeterminado, ingresa al navegador y ve a la parte de ajustes, busca el apartado de configuración de red que lo mas seguro es que se encuentre hasta el final de ajustes

**En la parte de Proxy HTTP ingresar localhost y en el apartado de Puerto poner 3128**

## PRIMER PASO

Clonar el repositorio dentro del apartado **Linux** que fue agregado con base a la instalación de Ubuntu, esto se encuentra muy cerca del apartado de **Este equipo**, ingresar a la carpeta de **Ubuntu**, dentro de esta carpeta ingresar a **home** y finalmente a la **carpeta de usuario** que anteriormente se asigno en la terminal de Ubuntu y en esta carpeta se clona el proyecto.

## SEGUNDO PASO

En este punto abrimos la terminal de Ubuntu, para esto primero abres tu terminal como normalmente se hace, en el apartado derecho viene una flecha hacia abajo, presionamos esta y nos mostrara vaarias terminales, en este caso seleccionamos la de Ubuntu

Con esto realizado y esta en la terminal de Ubuntu vamos a comenzar con las cosas solicitadas en proyecto. Primeramente ingresando el siguiente comando para colocarnos en la carpeta del proyecto, de igual manera es necesario abrir docker para este punto 
```bash
cd Proyecto-Final
```
### 1. Squid – Proxy

En este punto nos vamos a la carpeta de squid mediante 
```bash
cd Redes-proyecto
```
Dentro vamos a poner los siguientes comandos, cabe aclarar que en este punto puede que tarde argunos minutos, principalmente porque es la primera vez se se construye el contenedor y tambien depende mucho de la conexion a internet 
```bash
docker build -t squid-proxy .
```
En caso de que te marque error poner el siguiente comando y en caso de que no, hacer caso omiso a este apartado 
```bash
docker buildx build -t squid-proxy .
```
Esto lo que hace es que levantara el contenedor de squid y proxy, después de esto se ingresa el siguiente comando 
```bash
docker run -d --name squid-proxy -p 3128:3128 squid-proxy
```
Este comando permite la ejecución del contenedor. 

Podras apreciar como en Docker el contenedor de **squid-proxy** ya fue creado.Ahora bien dentro del navegador FireFox ya con la configuración establecida anteriormente podemos hacer la búsqueda de las siguientes páginas las cuales te mostraran una restricción por parte de proxy:

- Facebook.com

- Instagram.com

- GitHub.com

- Youtube.com

- TikTok.com

Cualquier otra pagina te debe permitir el acceso 

Para regresar a de carpeta se puede poner el comando `cd ..`

### 2. Host Virtuales

Despues de haber regresado a la  carpeta inicial, ponemos el siguiente comando para colocarnos en la carpeta
```bash
cd webserver
```
A continuacion colocar el siguiente comando, para la creacion del contenedor, esto puede tardar varios minutos 
```bash
docker network create apache-net
```
Despues poner el siguiente comando 
```bash
docker run -d --name apache-server --network apache-net -p 8080:80 apache-mis-sitios
```
Con esto, ya tenemos el contenedor incial para los host virtuales mediante apache, ahora es necesario crear un contenedor cliente que nos ayudara a que nuestro proyecto funcione correctamente, esto mediante el siguiente comando
```bash
docker run -it --rm --name cliente --network apache-net curlimages/curl sh
```
En caso de que este comando indique algun error colocar el siguiente comando que lo que hace es buscar la imagen, si esta no se encuentra la crea, si funciona correctamente es necesario volver a poner el comando `docker run -it --rm --name cliente --network apache-net curlimages/curl sh` .En caso de que el anterior comando a este no marcase ningun error, hacer caso omiso a este paso. 
```bash
docker pull curlimages/curl
```
Al poner este comando ya solo es necesario poner los siguientes comandos que nos mostraran el apto funcionamiento de esta parte del proyecto
```bash
curl -H "Host: site1.local" http://apache-server
```
```bash
curl -H "Host: site2.local" http://apache-server
```
```bash
curl -H "Host: site3.local" http://apache-server
```
Para regresar a de carpeta de webserver es necesario poner `exit` y para regresar a la carpeta del proyecto poner `cd ..`

### 3. DNS - Bind

Para este punto es necesario tener creados y en ejecucion los contenedores de squid-proxy y apache, ya colocados en la carpeta de **Proyecto-Final** nos vamos a la carpeta de dns con `cd dns-server`

Creamos el contenedor de dns con el siguiente comando, cabe aclarar que este proceso puede tardar algunos minutos ya que es la primera vez que se crea el contenedor
```bash
docker build -t dns-server .
```
Ejecutamos el contenedor
```bash
docker run -d --name dns-server --network apache-net -p 53:53/tcp -p 53:53/udp dns-server
```
En este punto es necesario crear un nuevo contenedor cliente, para no depender de la terminal temporal de las herramientas de dns, por eso mismo seguimos los siguientes pasos, primeramente `cd ..` para regresar a la carpeta del proyecto, despues nos colocamos en la carpeta cliente mediante `cd cliente`

Dentro de la carpeta cliente
```bash
docker build -t cliente-dns .
```
El comando anterior crea el contenedor cliente, este proceso puede tardar algunos minutos, cuando finalize ejecutamos el contenedor con el siguiente comando
```bash
docker run -it --name cliente --network apache-net cliente-dns
```
Despues de la ejecucion nos mandara a root, debe aparecer algo asi **root@2d7b8d2533e5:/#**, lo que nos indica estar dentro del contenedor y dentro de este vamos a probar al dns con los siguientes comandos
```bash
dig @dns-server www.site1.local
```
```bash
dig @dns-server www.site2.local
```
```bash
dig @dns-server www.site3.local
```
En cada uno de estos nos debe mostrar que el servidor fue encontrado, comprobando el funcionamiento de DNS-bind. Para regresar a de carpeta de cliente es necesario poner `exit` y para regresar a la carpeta del proyecto poner `cd ..`

### 4. ipTables

Para este este  punto es importante que todo lo anteriormente documentado ya este realizado y estemos colocados en la carpeta **Proyecto-Final**. Primero entramos a la carpeta `cd firewall-docker`, ya dentro lo primero que vamos hacer es construir el contenedor de docker-compose del firewall-docker que contiene el contenedor **clientea, clienteb y  firewall**, para esto primero usamos el siguiente comando 
```bash
docker-compose up -d
```
Este proceso puede tardar algunos minutos y es necesario que cada vez que se pruebe una nueva regla se vuelva a poner este comando, tambien sera necesario abrir otras 2 terminales de ubunto que es donde estaremos probando los contenedores de clientea y clienteb, en la primera terminal usualmente se usara para usar el contenedor de firewall, entonces dependiendo de la terminal en la que nos encontramos podemos poner los siguientes comandos.
```bash
docker exec -it firewall bash
```
```bash
docker exec -it clientea bash
```
```bash
docker exec -it clienteb bash
```
#### - Instalaciones necesarias 

apt update && apt install -y curl

#### 4.1  Denegar el acceso al puerto 80 (HTTP)

Despues de haber realizados los pasos anteriores 






