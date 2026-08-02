@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ============================================================
echo   Compilador Automatico a .EXE para Windows: HTML to Python Studio
echo ============================================================
echo.

set "PYTHON_EXEC="

if exist "python_env\python.exe" (
    set "PYTHON_EXEC=python_env\python.exe"
    echo [INFO] Usando Python Aislado/Portable localizado en \python_env\
) else if exist "python\python.exe" (
    set "PYTHON_EXEC=python\python.exe"
    echo [INFO] Usando Python Portable localizado en \python\
) else (
    python --version >nul 2>&1
    if !ERRORLEVEL! EQU 0 (
        set "PYTHON_EXEC=python"
        echo [INFO] Usando Python instalado en el Sistema.
    )
)

if "%PYTHON_EXEC%"=="" (
    echo [AVISO] No se detecto Python en el sistema ni en \python_env\.
    echo Intentando descargar e instalar automaticamente Python Portable en \python_env\...
    echo.
    if not exist "python_env" mkdir "python_env"
    powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.9/python-3.11.9-embed-amd64.zip' -OutFile 'python_env\python_embed.zip'"
    if exist "python_env\python_embed.zip" (
        powershell -Command "Expand-Archive -Path 'python_env\python_embed.zip' -DestinationPath 'python_env' -Force"
        del "python_env\python_embed.zip"
        powershell -Command "(Get-Content python_env\python311._pth) -replace '#import site', 'import site' | Set-Content python_env\python311._pth"
        powershell -Command "Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile 'python_env\get-pip.py'"
        python_env\python.exe python_env\get-pip.py --no-warn-script-location
        del "python_env\get-pip.py"
        set "PYTHON_EXEC=python_env\python.exe"
        echo [EXITO] Entorno Python Portable instalado en \python_env\
    ) else (
        echo [ERROR] No se pudo descargar Python. Por favor instala Python o ejecuta con conexion a internet.
        pause
        exit /b 1
    )
)

echo [1/3] Verificando e instalando dependencias requeridas con !PYTHON_EXEC!...

!PYTHON_EXEC! -m PyInstaller --version >nul 2>&1
if !ERRORLEVEL! NEQ 0 (
    echo   - Instalando PyInstaller...
    !PYTHON_EXEC! -m pip install pyinstaller
) else (
    echo   - PyInstaller ya esta instalado.
)

!PYTHON_EXEC! -c "import webview" >nul 2>&1
if !ERRORLEVEL! NEQ 0 (
    echo   - Instalando PyWebView...
    !PYTHON_EXEC! -m pip install pywebview
) else (
    echo   - PyWebView ya esta instalado.
)

!PYTHON_EXEC! -c "import clr" >nul 2>&1
if !ERRORLEVEL! NEQ 0 (
    echo   - Instalando pythonnet...
    !PYTHON_EXEC! -m pip install pythonnet
) else (
    echo   - pythonnet ya esta instalado.
)

echo.
echo [2/3] Buscando archivo de icono (.ico) en el directorio...
set "ICON_CMD="
if exist "icon.ico" (
    set "ICON_CMD=--icon=icon.ico"
    echo   - Icono detectado: icon.ico
    goto :found_icon
)
if exist "app.ico" (
    set "ICON_CMD=--icon=app.ico"
    echo   - Icono detectado: app.ico
    goto :found_icon
)
for %%i in (*.ico) do (
    set "ICON_CMD=--icon=%%i"
    echo   - Icono detectado: %%i
    goto :found_icon
)
echo   - No se detecto archivo .ico. Se usara el icono ejecutable predeterminado.
:found_icon

echo.
echo [3/3] Compilando ejecutable .EXE de Windows con PyInstaller...
!PYTHON_EXEC! -m PyInstaller --noconfirm --onedir --windowed --add-data "index.html;." !ICON_CMD! --name "HTMLtoPythonStudio" main.py

if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ============================================================
    echo [ERROR] Ocurrio un fallo durante el proceso de compilacion.
    echo Revisa los mensajes de error mostrados arriba para corregirlo.
    echo ============================================================
    echo.
    pause
    exit /b !ERRORLEVEL!
)

echo.
echo ============================================================
echo ¡Compilacion realizada exitosamente!
echo Tu ejecutable se encuentra en: dist\HTMLtoPythonStudio\HTMLtoPythonStudio.exe
echo ============================================================
timeout /t 3 >nul
exit /b 0
