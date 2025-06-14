# Proyecto-Final-Redes

Proyecto Final de Redes de Computadores, donde se implementó proxy, host virtuales, DNS e Iptables

### Requisitos para el funcionamiento del proyecto 

#### - Instalación de Docker

En cualquier navegador disponible en el dispositivo buscar docker, ingrear a la primera pagina disponible e ir al aparatdo de descarga, en ese apartado hay varias opciones de instalacion, elige la mas apropiada segun tu PC. En Docker es recomendable crear una cuenta para el optimo funcionamiento 

[Instalacion de Docker](https://www.docker.com/)

#### - Instalar WSL mediante los siguientes comandos en la terminal

`wsl --install`

Esto instalará WSL, la última versión del kernel de Linux y Ubuntu automáticamente (en Windows 11). Después reiniciar la PC o laptop y por último, configure WSL 2 como predeterminado con el siguiente comando:

`wsl --set-default-version 2`

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

`cd Proyecto-Final`

### 1. Squid – Proxy

En este punto nos vamos a la carpeta de squid mediante 

`cd Redes-proyecto`

Dentro vamos a poner los siguientes comandos 

`docker build -t squid-proxy .`

En caso de que te marque error poner el siguiente comando 

`docker buildx build -t squid-proxy .`

Esto lo que hace es que levantara el contenedor de squid y proxy, después de esto se ingresa el siguiente comando 

`docker run -d --name squid-proxy -p 3128:3128 squid-proxy`

Este comando permite la ejecución del contenedor. Dentro del navegador FireFox ya con la configuración establecida anteriormente podemos hacer la búsqueda de las siguientes páginas las cuales te mostraran una restricción por parte de proxy:

- Facebook.com

- Instagram.com

- GitHub.com

- Youtube.com

- TikTok.com

Cualquier otra pagina te debe permitir el acceso 

Para regresar a de carpeta se puede poner el comando `cd ..`

