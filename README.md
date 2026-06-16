# Gistar Web - Dokploy Deployment Config

Este repositorio contiene el sitio web estático de Gistar, configurado con tu servidor web **Nginx** original para su despliegue mediante Docker en **Dokploy**.

## 🛠️ Configuración de Ruteo (Nginx)

El archivo de configuración [default.conf](file:///var/gistar/web/code/web/default.conf) contiene exactamente tu configuración original con soporte para SSL, ruteo de URLs amigables, descarga del reglamento y aliases:
* **Root del Sitio**: `/var/www/html/web`
* **Dominios (`server_name`)**: `www.gistar.com.py` y `gistar.com.py`
* **Certificados SSL**:
  - `ssl_certificate /etc/letsencrypt/live/gistar.com.py/fullchain.pem;`
  - `ssl_certificate_key /etc/letsencrypt/live/gistar.com.py/privkey.pem;`

---

## 🚀 Despliegue en Dokploy

Como el `default.conf` hace uso de los certificados SSL locales (`/etc/letsencrypt`) y la carpeta de verificación de Certbot (`/var/www/certbot`), debes configurar los volumenes (**Volumes**) en Dokploy para que el contenedor Nginx tenga acceso a ellos. De lo contrario, Nginx fallará al iniciar por falta de los certificados.

### Paso 1: Configurar el Servicio en Dokploy
1. **Crea un nuevo Servicio** del tipo **Application** en Dokploy.
2. Vincula tu repositorio `chelonso/gistar-web` y rama `main`.
3. En **Build Config**, asegúrate de que el tipo de construcción sea **Dockerfile**.

### Paso 2: Agregar los Volúmenes (Volumes)
En la configuración del servicio dentro de Dokploy, ve a la sección de **Volumes** y monta los directorios de tu servidor host correspondientes a Let's Encrypt y Certbot:

* **Volumen de Certificados**:
  - **Host Path**: `/etc/letsencrypt`
  - **Mount Path**: `/etc/letsencrypt`
* **Volumen de Certbot (Desafío ACME)**:
  - **Host Path**: `/var/www/certbot`
  - **Mount Path**: `/var/www/certbot`

### Paso 3: Puertos y Redirección
1. Nginx expone tanto el puerto **`80`** (HTTP) como el **`443`** (HTTPS).
2. Configura Dokploy para exponer ambos puertos al host, o asocia los dominios `gistar.com.py` y `www.gistar.com.py` en la pestaña de Dominios apuntando directamente al puerto `443` o `80` (dependiendo de si prefieres que tu Dokploy maneje el proxy inverso SSL externo o use tu Nginx directamente).
