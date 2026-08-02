# -*- coding: utf-8 -*-
"""
Generado automáticamente por HTML to Python, APK & Windows Studio
Nombre de la App: HTML to Python Studio
Versión: 1.0.0
"""

import os
import sys

APP_NAME = "HTML to Python Studio"
def get_resource_path(relative_path):
    """ Obtiene la ruta absoluta para el recurso, compatible con desarrollo y PyInstaller/Buildozer """
    if hasattr(sys, '_MEIPASS'):
        return os.path.join(sys._MEIPASS, relative_path)
    return os.path.join(os.path.abspath("."), relative_path)

INDEX_PATH = get_resource_path("index.html")

def run_android():
    from kivy.app import App
    from kivy.uix.boxlayout import BoxLayout
    from kivy.utils import platform
    from android.runnable import run_on_ui_thread
    from android.permissions import request_permissions, Permission
    from jnius import autoclass, PythonJavaClass, java_method

    WebView = autoclass('android.webkit.WebView')
    WebViewClient = autoclass('android.webkit.WebViewClient')
    WebChromeClient = autoclass('android.webkit.WebChromeClient')
    Activity = autoclass('org.kivy.android.PythonActivity').mActivity
    Environment = autoclass('android.os.Environment')
    Base64 = autoclass('android.util.Base64')
    FileOutputStream = autoclass('java.io.FileOutputStream')
    File = autoclass('java.io.File')
    Toast = autoclass('android.widget.Toast')

    class JSDownloadListener(PythonJavaClass):
        __javainterfaces__ = ['android/webkit/DownloadListener']
        __javacontext__ = 'app'

        def __init__(self, activity):
            super(JSDownloadListener, self).__init__()
            self.activity = activity

        @java_method('(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V')
        def onDownloadStart(self, url, userAgent, contentDisposition, mimetype, contentLength):
            try:
                if url.startswith("data:"):
                    header, data = url.split(",", 1)
                    file_bytes = Base64.decode(data, Base64.DEFAULT)
                    filename = "backup_file.json"
                    if "filename=" in contentDisposition:
                        filename = contentDisposition.split("filename=")[1].strip('" ;')
                    
                    download_dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
                    out_file = File(download_dir, filename)
                    fos = FileOutputStream(out_file)
                    fos.write(file_bytes)
                    fos.close()

                    Toast.makeText(self.activity, f"Guardado en Descargas: {filename}", Toast.LENGTH_LONG).show()
            except Exception as e:
                print(f"Error procesando descarga: {e}")

    class MainAndroidApp(App):
        def build(self):
            self.title = APP_NAME
            layout = BoxLayout(orientation='vertical')
            request_permissions([
                Permission.INTERNET,
                Permission.READ_EXTERNAL_STORAGE,
                Permission.WRITE_EXTERNAL_STORAGE
            ])
            self.create_webview()
            return layout

        @run_on_ui_thread
        def create_webview(self):
            webview = WebView(Activity)
            settings = webview.getSettings()
            settings.setJavaScriptEnabled(True)
            settings.setDomStorageEnabled(True)
            settings.setDatabaseEnabled(True)
            settings.setAllowFileAccess(True)
            settings.setAllowContentAccess(True)
            settings.setAllowFileAccessFromFileURLs(True)
            settings.setAllowUniversalAccessFromFileURLs(True)
            
            webview.setWebViewClient(WebViewClient())
            webview.setWebChromeClient(WebChromeClient())
            webview.setDownloadListener(JSDownloadListener(Activity))
            
            webview.loadUrl("file://" + INDEX_PATH)
            Activity.setContentView(webview)

    MainAndroidApp().run()

def run_windows_desktop():
    try:
        import webview
        window = webview.create_window(
            title=APP_NAME,
            url="file://" + INDEX_PATH,
            width=1024,
            height=720,
            resizable=True,
            fullscreen=False
        )
        webview.start()
    except ImportError:
        import webbrowser
        print("Módulo 'pywebview' no encontrado. Abriendo en navegador predeterminado...")
        webbrowser.open("file://" + INDEX_PATH)

if __name__ == '__main__':
    try:
        from kivy.utils import platform
        if platform == 'android':
            run_android()
        else:
            run_windows_desktop()
    except Exception:
        run_windows_desktop()
