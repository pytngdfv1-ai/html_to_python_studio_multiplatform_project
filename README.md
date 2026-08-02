# HTML to Python Studio - Proyecto Multiplataforma (Android & Windows)

Este proyecto ha sido generado automáticamente por **HTML to Python, APK & Windows Studio**.

⚠️ **IMPORTANTE AL SUBIR A GITHUB**:
Asegúrate de copiar todos los archivos del ZIP **directamente en la raíz de tu repositorio** en GitHub.
Archivos clave como `buildozer.spec`, `main.py` e `index.html` **NO deben quedar metidos dentro de una subcarpeta**, de lo contrario GitHub Actions fallará con el error *"No buildozer.spec found"*.

---

## 🐍 ¿Cómo ejecutar la app directamente en Python (Sin compilar a .EXE)?

### Opción A: Ejecución rápida de 1-Clic sin ventana de consola (Recomendado)
Simplemente haz **doble clic en `ejecutar_app.bat`**.
- Utiliza `pythonw.exe` en segundo plano, por lo que **no se abrirá ninguna ventana negra de CMD**.
- La aplicación se abre directamente como si fuera un programa nativo.
- Cuando cierres la ventana de la app, el proceso finaliza por completo.

---

## 💻 Compilación Local en Windows en 1-Clic (.EXE)
1. Descomprime este archivo `.zip` en tu computadora.
2. *(Opcional)* Si deseas un ícono personalizado, coloca tu archivo `.ico` en esta misma carpeta (ejemplo: `icon.ico` o `app.ico`).
3. Haz **doble clic en `compilar_windows.bat`**.
4. El script detectará automáticamente las librerías necesarias y dejará tu ejecutable `.exe` dentro de la carpeta `/dist/`.

---

## 🚀 Compilación Automática de Android (.APK) en la Nube
1. Subes todo el contenido descomprimido de este ZIP a un repositorio en **GitHub**.
2. Ve a la pestaña **Actions** en tu repositorio de GitHub.
3. El flujo de trabajo compilará automáticamente en paralelo:
   - **Android-APK** (mediante Ubuntu + Buildozer)
   - **Windows-EXE** (mediante Windows + PyInstaller)
4. Descarga tus ejecutables instalables directamente desde la sección de artefactos de GitHub.
