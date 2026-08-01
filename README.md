# HTML to Python Studio - Proyecto Multiplataforma (Android & Windows)

Este proyecto ha sido generado automáticamente por **HTML to Python, APK & Windows Studio**.

## 🐍 ¿Cómo ejecutar la app directamente en Python (Sin compilar a .EXE)?

### Opción A: Ejecución rápida de 1-Clic sin ventana de consola (Recomendado)
Simplemente haz **doble clic en `ejecutar_app.bat`**.
- Utiliza `pythonw.exe` en segundo plano, por lo que **no se abrirá ninguna ventana negra de CMD**.
- La aplicación se abre directamente como si fuera un programa nativo.
- Cuando cierres la ventana de la app, el proceso finaliza por completo.

### Opción B: Usando el entorno de Python aislado/portátil (`python_env`)
1. Si no tienes Python en tu sistema, entra a la carpeta `python_env\` y ejecuta `instalar_python_portatil.bat` (descargará Python 3.11 e instalará sus librerías de forma aislada).
2. Haz doble clic en `ejecutar_app.bat`, detectará automáticamente la versión de `python_env\`.

---

## 💻 Compilación Local en Windows en 1-Clic (.EXE)
1. Descomprime este archivo `.zip` en tu computadora.
2. *(Opcional)* Si deseas un ícono personalizado, coloca tu archivo `.ico` en esta misma carpeta (ejemplo: `icon.ico` o `app.ico`).
3. Haz **doble clic en `compilar_windows.bat`**.
4. El script detectará automáticamente si usas `python_env\python.exe` o el Python global, instalará las librerías necesarias y dejará tu ejecutable `.exe` dentro de la carpeta `/dist/`.

---

## 🎨 Íconos Personalizados de la Aplicación

- **Para Windows (.EXE):** Coloca tu imagen en formato `.ico` (ejemplo: `icon.ico`) en la carpeta raíz. `compilar_windows.bat` lo asignará automáticamente al archivo ejecutable.
- **Para Android (.APK):** Coloca tu imagen en formato `.png` (512x512px recomendado) nombrada `icon.png` en la carpeta raíz del proyecto antes de subir a GitHub o compilar.

---

## 🚀 Compilación Automática de Android (.APK) en la Nube
1. Subes todo el contenido descomprimido de este ZIP a un repositorio en **GitHub**.
2. Ve a la pestaña **Actions** en tu repositorio de GitHub.
3. El flujo de trabajo compilará automáticamente en paralelo:
   - **Android-APK** (mediante Ubuntu + Buildozer)
   - **Windows-EXE** (mediante Windows + PyInstaller)
4. Descarga tus ejecutables instalables directamente desde la sección de artefactos de GitHub.
