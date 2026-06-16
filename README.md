# Guía de Despliegue para Dokploy

¡Listo! Ya hemos convertido el sitio web de Gistar en un repositorio Git local, configurado el archivo `.gitignore` y creado un `Dockerfile` optimizado con Nginx para servir los archivos estáticos de forma eficiente.

A continuación, sigue estos pasos para subir tu código a un repositorio remoto (como GitHub) y desplegarlo en tu instancia de Dokploy.

---

## Paso 1: Subir el repositorio a GitHub (o GitLab/Gitea)

1. Ve a [GitHub](https://github.com) y crea un nuevo repositorio (por ejemplo, `gistar-web`).
   - *Nota: No agregues archivos README, .gitignore o licencia en GitHub, ya que los acabamos de crear localmente.*

2. En tu terminal local, dentro del directorio de este repositorio, ejecuta los siguientes comandos para vincular y subir tu código:

   ```bash
   # Cambiar el nombre de la rama por defecto a 'main' (opcional pero recomendado)
   git branch -M main

   # Agregar la dirección de tu repositorio remoto
   git remote add origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git

   # Subir el código a GitHub
   git push -u origin main
   ```

---

## Paso 2: Configurar el despliegue en Dokploy

Dokploy utiliza Docker y Nixpacks de manera nativa. Gracias al `Dockerfile` que hemos creado, Dokploy detectará automáticamente la configuración de Nginx y desplegará tu web sin configuraciones complejas.

1. **Entra a tu panel de Dokploy**.
2. **Crea un nuevo Proyecto** (o selecciona uno existente).
3. **Crea un nuevo Servicio** del tipo **Application** (Aplicación).
4. Configura el origen del código (**Source**):
   - Selecciona **GitHub** (o tu proveedor Git correspondiente). Si es la primera vez, tendrás que autorizar a Dokploy a acceder a tu cuenta o repositorio.
   - Elige el repositorio (ej. `TU_USUARIO/TU_REPOSITORIO`) y la rama (`main`).
5. En la sección de **Build Config** (Configuración de construcción):
   - Dokploy debería detectar automáticamente tu `Dockerfile`. Asegúrate de que el tipo de construcción esté seleccionado como **Dockerfile** (en lugar de Nixpacks o Heroku Buildpacks).
6. Configura los **Puertos**:
   - Nginx por defecto corre en el puerto `80`. Dokploy expondrá automáticamente el puerto adecuado o te permitirá configurar un dominio con HTTPS (Dokploy gestiona los certificados SSL automáticamente con Let's Encrypt).
7. Haz clic en **Deploy** (Desplegar).

¡Y listo! Dokploy descargará el código de tu repositorio, compilará la imagen de Docker usando Nginx y expondrá el sitio web en el dominio que le asignes.
