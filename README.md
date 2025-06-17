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

Para este este  punto es importante que todo lo anteriormente documentado ya este realizado y estemos colocados en la carpeta **Proyecto-Final**. Primero aplicamos el siguente comando
```bash
sed -i 's/\r$//' firewall-docker/firewall/reglas.sh
```
Despues nos vamos a la carpeta `cd firewall-docker`, ya dentro lo primero que vamos hacer es construir el contenedor de docker-compose del firewall-docker que contiene el contenedor **clientea, clienteb y  firewall**, para esto primero usamos el siguiente comando 
```bash
docker-compose up --build -d
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
#### - Datos necesarios 
Comando necesario para las actualizaciones
```bash
apt update
```
Comando necesario para actualizar y guardar las reglas
```bash
./reglas.sh
```
Comando necesario para ver el estado de las iptables, usualmente este comando ayuda a saber si las reglas se estan cumpliendo de forma correcta
```bash
iptables -L -v -n
```
#### 4.1 Denegar el acceso al puerto 80 (HTTP)

Despues de haber realizados los pasos anteriores es necesario abrir el archivo **reglas.sh**, este documento esta todo comentado, para esta primer regla es necesario quitar lo comentado, esto se hace simplemente eliminando el **#**. El primer paso es ingresar el comando para ver las iptables, el cual muestra que no hay ninguna regla aplicada, por esto mismo usamos el comando para actualizar y guardar reglas.

Despues de estos, no dirigimos a el contenedor clientea que se abrio en segunda instancia y ejecutamos el siguiente comando
```bash
 curl http://192.168.200.2
```
Nos mostrara una salida la cual nos indica que no se pudo conectar con el servidor, eso ya cumple con la regla pero si deseamos comprobar esto podemos regresar al contenedor de firewall y ejecutar el comando de iptables, si se nos muestra que paquetes y bytes son difrentes de cero entonces si funciono adecuadamente

#### 4.2 Bloquear el acceso al puerto 21 (FTP) 

Es necesario quitar el comentario de la segunda regla y colocar de nuevo el de la primera regla, despues de esto repetimos todo el proceso inicial, en firewall colocamos el comando de iptables y despues el de guardado de reglas, esto para poder actualizar todo, despues nos vamos a el contenedor clienteb y ejecutamos el siguiente comando 
```bash
telnet 192.168.200.2 21
```
Debe arrojar algo asi **Trying 192.168.200.2... telnet: Unable to connect to remote host: Connection refused** esto nos indica que efectivamente se bloqueo el acceso al puerto 21, solo quedaria comprobarlo, para esto se ingresa el comando de iptables en firewall en el cual debemos ver algun paquete y byte para ver que efectivamente la regla esta funcionando

#### 4.3 Denegar el tráfico de salida

Es necesario quitar el comentario de la tercera regla y colocar de nuevo el de la segunda regla, despues de esto repetimos todo el proceso inicial, en esta ocasion trabajaremos especialmente en el contenedor de firewall, entonces primeramente instalamos ping en este contenedor de la siguiente forma 
```bash
apt-get update && apt-get install -y iputils-ping
```
Despues de esto podemos ingresar el comando de iptables y el de actualizacion y guardado de reglas

Lo que sigue en este punto es colocar alguna de las siguientes ips que se encuentran en el rango de lo solicitado en esta regla
```bash
ping -c 2 192.168.200.10
ping -c 2 192.168.200.20
```
Cualquiera de estas ips o las que se encuentren en el rango deberian mandar un mensaje similar a este despues de ping **PING 192.168.200.20 (192.168.200.20) 56(84) bytes of data. --- 192.168.200.20 ping statistics --- 2 packets transmitted, 0 received, 100% packet loss, time 1038ms**, la forma de comprobar el funcionamiento de esta regla es que cada vez que hagamos un ping ingresemos el comando de iptables que nos mostrara el aumento de paquetes y bytes

Otra forma de mostrar el funcionamineto es ingresando unas ips fuera del rango solicitado como las siguientes 
```bash
ping -c 2 192.168.200.128
ping -c 2 192.168.200.5
```
 Estas al estar fuera del rango de red no necesariamente dan una respuesta, lo importante de estas es que si aplicamos nuevamente el comando de iptables se podra ver que no hubo aumento de paquetes bloqueados, esto indica que esta respetando el rango establecido

 #### 4.4 Bloquear las respuestas ICMP tipo “ping” (echo-reply) 

Es necesario quitar el comentario de la cuarta regla y colocar de nuevo el de la tercera regla, despues de esto repetimos todo el proceso inicial, despues de esto simplemente nos vamos al contenedor de firewall y ponemos los comandos de iptables y gusrdado y actualizacion de reglas, las reglas se deberian ver aplicadas

 En el contenedor de clientea vamos a poner el siguiente comando
 ```bash
ping -c 4 192.168.200.2
```
Lo normal es que como repuesta obtengamos lo siguiente **PING 192.168.200.2 (192.168.200.2) 56(84) bytes of data --- 192.168.200.2 ping statistics --- 4 packets transmitted, 0 received, 100% packet loss, time 3052ms**, en el firewall podemos ingresar el comando de iptables y este nos va a indicar cierto numero de paquetes lo cual en este punto es bueno ya que idica el apto funcionamiento de la regla 4.

Otra forma de mostrar el funcionamiento es haciendo lo siguiente, ingresamos el siguiente comando que desactiva la regla temporalmente 
```bash
iptables -D OUTPUT -p icmp --icmp-type echo-reply -j DROP
```
Si volvemos a aplicar el ping desde cliente a podremos observar que los paquetes en esta ocasion si son recibidos y no hay ninguna perdida, comfirmando que la regla es la que esta bloqueando las respuestas, es importante ingresar el siguiente comando para restaurar la regla 
```bash
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP
```
 #### 4.6 Limitar el número de conexiones simultáneas por equipo a un máximo de 20. 

Es necesario quitar el comentario de la sexta regla y colocar de nuevo el de la cuarta regla, despues de esto repetimos todo el proceso inicial, para esta regla vamos a trabajar en clientea, asi que nos metemos en su contenedor, tambien es necesario en otra terminal meternos de nuevo al contenedor firewall ya que vamos a hacer pruebas simultaneas en firewall, para esto primero vamos a instalar netcat con el siguiente comando 
```bash
apt update
apt install -y netcat-openbsd
```
Con esto instalado ingresamos el siguiente comando el cual hace una espera de conexiones en el puerto 80, cabe aclarar que no se recibira respuesta alguna hasta ingresar el comando correspondiente, para probar la regla 6 
```bash
nc -l -p 80
```
En el contenedor de clientea se ingresa el siguiente comando que prueba la regla 6  
```bash
for i in $(seq 1 25); do telnet 192.168.200.2 80 & done
```
Es normal que como respuesta se arroje lo siguiente 
**Connection to 192.168.200.2 80 port [tcp/http] succeeded!
Connection to 192.168.200.2 80 port [tcp/http] failed: Connection refused
...** 

Se quedara esperando respuesta y en el contenedor firewall que se encuentra en otra terminal verificamos el funcionamiento ingresando el comando de iptables, eso nos arrojara una respuesta en cuanto a paquetes y bytes, es necesario hacer varias pruebas para comprobar el limite de conexiones simultaneas del equipo, cuando se obtenga un numero alto de paquetes que supere las 20 conexiones simultaneas se activara el RECJECT, entonces ya con esto mostramos el funcionamiento de la regla 

 #### 4.7 Bloquear todo tráfico saliente a sitios con destino al puerto 443 (HTTPS)

Es necesario quitar el comentario de la septima regla y colocar de nuevo el de la sexta regla, despues de esto repetimos todo el proceso inicial, en esta ocasion solo vamos a trabajar con el contenedor de firewall, entonces primeramente se asignara el comando de iptables para verificar que la regla esta activada, despues es necesario instalar curl para poder trabajar y verificar esta regla, por eso mismo ingresamos el siguiente comando 
 ```bash
apt-get update
apt-get install -y curl
```
Despues de que se realice la instalacion podemos continuar con la practica ingresando el siguiente comando
```bash
curl https://google.com:443
```
Si todo esta correcto debemos recibir la siguinte respuesta o algo similar **curl: (7) Failed to connect to google.com port 443 after 27 ms: Couldn't connect to server**, aunque ya con esto comprobamos que si esta bloqueando el trafico saliente a sitios con destino al puerto 443 tambien podemos ingresar el comando de iptables y si los paquetes y bytes se activaron todo funciona correctamente 

 #### 4.8 Permitir únicamente tráfico SSH (puerto 22) desde una IP autorizada 

 Es necesario quitar el comentario de la octava regla y colocar de nuevo el de la septima regla, despues de esto repetimos todo el proceso inicial, en el contenedor de firewalls usamos el comando de iptables para ver si la regla esta activa, en el contenedor de clientea vamos a probar el siguiente comando
 ```bash
ssh root@192.168.200.2
```
Despues de este comando te va a pedir que cofirmes si quieres continuar con la conexion, se debe escribir **yes**, despues de esto te  pedira una contraseña para root, se debe ingresar la siguiente
 ```bash
rootpassword
```
Esto nos permitira entrar y se comprueba que permite el trafico, en este punto es necesario verificar que funciono adecuadamente, entonces en el firewall ponemos el comando de iptables y si los paquetes no se activaron demuestra el apto funcionamineto de esta regla

Para comprobar que si funciono todo, en firewall ponemos ponemos el comando `ssh root@192.168.200.2`, donde deberia mandarnos un mensaje como este **ssh: connect to host 192.168.200.2 port 22: Connection refused**. Si ingresamos nuevamente el comando de iptables podemos ver que en esta ocasion los paquetes si se activaron y eso demuestra que todo fucniona correctamente
 





