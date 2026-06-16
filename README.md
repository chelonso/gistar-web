# Gistar Web - Dokploy Deployment Config

Este repositorio contiene el sitio web estático de Gistar, configurado con un servidor web **Nginx** integrado para facilitar su despliegue mediante contenedores Docker en plataformas como **Dokploy**.

## 🛠️ Configuración de Ruteo (Nginx)

Hemos adaptado e integrado la configuración previa de Nginx en el contenedor para que respete las siguientes reglas:
1. **Rutas amigables / limpias**: Configuración de `try_files` para que direcciones como `/challenge` busquen automáticamente `/challenge.html` antes de redirigir a `/index.html`.
2. **Descarga del Reglamento**: La ruta `/reglamento` apunta como un alias al archivo PDF `/files/reglamento.pdf` y fuerza la descarga con las cabeceras correspondientes.
3. **Caché y Optimización**: Los assets estáticos (CSS, JS, imágenes, etc.) tienen habilitada la cabecera de expiración máxima (`Cache-Control: public, max-age=31536000`).

---

## 🚀 Despliegue en Dokploy

Dado que ya tenemos un `Dockerfile` y la configuración personalizada de Nginx (`default.conf`), sigue estos pasos en Dokploy para ponerlo en producción:

1. **Entra a tu panel de Dokploy**.
2. **Crea un nuevo Proyecto** (o selecciona uno existente).
3. **Crea un nuevo Servicio** del tipo **Application** (Aplicación).
4. Configura el origen del código (**Source**):
   - Selecciona **GitHub** y asocia este repositorio: `chelonso/gistar-web`.
   - Selecciona la rama: `main`.
5. En la sección **Build Config**:
   - Asegúrate de seleccionar **Dockerfile** como proveedor de construcción (Dokploy detectará el `Dockerfile` que está en la raíz).
6. Configura el **Puerto**:
   - Expón el puerto **`80`** (que es donde Nginx escucha por defecto dentro del contenedor). Dokploy se encargará de mapearlo al puerto público de tu preferencia o asignarle un dominio con SSL automático de Let's Encrypt.
7. Haz clic en **Deploy**.

¡Eso es todo! Dokploy construirá la imagen del contenedor y servirá el sitio web con todas las reglas de ruteo y alias configuradas.
