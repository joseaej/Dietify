## Versiones

A continuación se detallan las versiones de la aplicación y los cambios realizados en cada una:

### Versión 0.0.1
- **Añadido**: Interfaz gráfica para el registro y logueo de la app.
  - Conexión con Supabase para la autentificacíon de usuario.
  - Añadida logica para guardar datos en la tabla Profile como email y nombre de usuario.
  - Guardada preferencias localmente para un acceso más rapido.
  - Añadido dotenv para seguridad de las claves.

### Versión 0.0.2
- **Añadido**: Intefeaz para el on boarding de la app.
  - Animaciones en el onboarding.
- **Arreglado**: Logica para iniciar sesion si esta logueado.

### Versión 0.0.3
- **Añadido**: Intefeaz para los ajustes de la app.
  - Metodos para cargar fotos desde la galeria y la camara.
  - Interfaz de carga.
  - Guardado local de los ajustes de la aplicación.
  - Cargado de ajustes cuando se inicia la aplicación.
  - Cambiar de tema a claro o oscuro.
  - Cerrar sesión.
  - Eliminar cuenta de la base de datos.
  - Guardar imagen en el storage medianete un bucket.
  - Guardado local y carga local. 
- **Arreglado**: Provider para la carga del perfil.
  - Provider para la carga de los ajustes.
  - Inyeccion de los ajustes en el main.
  - Guardado de la foto

### Versión 0.0.4
- **Añadido**: Añadido Workouts de la app
  - Consulta de Workouts
  - Filtrado de Workouts
  - Detalles de entrenamientos

### Versión 0.0.5
- **Añadido**: Añadido Home Screen
  - Añadido water intake
  - Entrenamientos recomendados
  - Calorias consumidas
