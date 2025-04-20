# Imagen base moderna con Flutter 3.19
FROM ghcr.io/cirruslabs/flutter:3.19.6

# Directorio de trabajo
WORKDIR /app

# Copiamos solo pubspec para cache de dependencias
COPY pubspec.* ./

# Instalamos dependencias
RUN flutter pub get

# Copiamos el resto del proyecto
COPY . .

# Aceptamos licencias del SDK Android
RUN yes | flutter doctor --android-licenses

# Compilamos el APK release
RUN flutter build apk --release

# Imagen final mínima para exportar el APK
FROM alpine:latest
WORKDIR /output
COPY --from=0 /app/build/app/outputs/flutter-apk/app-release.apk .

CMD ["ls", "-lh"]