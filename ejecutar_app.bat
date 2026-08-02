@echo off
cd /d "%~dp0"

if exist "python_env\pythonw.exe" (
    start "" "python_env\pythonw.exe" main.py
    exit
)
if exist "python_env\python.exe" (
    start "" "python_env\python.exe" main.py
    exit
)

pythonw --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    start "" pythonw main.py
    exit
)

python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    start "" python main.py
    exit
)

echo ============================================================
echo [ERROR] No se detecto Python en el sistema ni en \python_env\.
echo.
echo Para solucionarlo:
echo 1. Instala Python 3 en tu sistema, o
echo 2. Ejecuta \python_env\instalar_python_portatil.bat para descargar
echo    un Python portable e independiente en esta carpeta.
echo ============================================================
pause
