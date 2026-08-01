[app]
title = HTML to Python Studio
package.name = htmltopythonstudio
package.domain = org.miejemplo
source.dir = .
source.include_exts = py,png,jpg,kv,atlas,html,css,js,json
icon.filename = %(source.dir)s/icon.png
version = 1.0.0
requirements = python3,kivy,android,pyjnius
orientation = portrait
fullscreen = 1
android.permissions = INTERNET,READ_EXTERNAL_STORAGE,WRITE_EXTERNAL_STORAGE
android.accept_sdk_licence = True
android.api = 33
android.minapi = 21
android.ndk = 25b
android.archs = arm64-v8a, armeabi-v7a

[buildozer]
log_level = 2
warn_on_root = 1
