# Gistar Web - Dokploy Deployment Config

Este repositorio contiene el sitio web estático de Gistar, configurado con tu servidor web **Nginx** adaptado para su despliegue en **Dokploy**.

## 🛠️ Configuración de Ruteo (Nginx)

El archivo de configuración [default.conf](file:///var/gistar/web/code/web/default.conf) contiene tu configuración de ruteo original adaptada para correr detrás de un proxy inverso (como el de Dokploy):
* **Puerto**: Escucha en el puerto `80`.
* **Root del Sitio**: `/var/www/html/web`
* **Dominios (`server_name`)**: `www.gistar.com.py` y `gistar.com.py`.
* **Descarga del Reglamento**: La ruta `/reglamento` apunta como un alias al archivo PDF `/files/reglamento.pdf` y fuerza la descarga.
* **URLs Amigables**: Soporta `try_files` para que `/challenge` resuelva a `/challenge.html` antes de fallback a `/index.html`.

---

## 🚀 Despliegue en Dokploy

Como **Dokploy se encarga del SSL de forma automática**, no necesitas configurar volúmenes de certificados ni certbot en tu contenedor. Dokploy manejará el certificado SSL de Let's Encrypt externamente y redirigirá el tráfico HTTP al puerto `80` del contenedor.

### Paso 1: Configurar el Servicio en Dokploy
1. **Crea un nuevo Servicio** del tipo **Application** en Dokploy.
2. Vincula tu repositorio `chelonso/gistar-web` y rama `main`.
3. En **Build Config**, asegúrate de que el tipo de construcción sea **Dockerfile**.

### Paso 2: Configurar Dominios y SSL en Dokploy
1. Ve a la pestaña **Domains** (Dominios) del servicio en Dokploy.
2. Agrega tus dominios:
   - `gistar.com.py`
   - `www.gistar.com.py`
3. Configura el **puerto del contenedor** como **`80`**.
4. Activa la opción de **SSL** para que Dokploy genere y renueve los certificados automáticamente.
5. Haz clic en **Deploy**.

¡Eso es todo! Dokploy compilará la imagen, iniciará el contenedor en el puerto `80`, gestionará el certificado SSL y resolverá la web con todas tus reglas de ruteo configuradas.
