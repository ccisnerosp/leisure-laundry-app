Coloca aquí el archivo de alarma del temporizador de ciclos (OM-01):

    alarma.mp3

Recomendación: un tono de alarma de alta intensidad de 3-5 segundos en bucle.
La app lo reproduce vía `AlarmaService` cuando un ciclo termina y la app está
en primer plano. Si el archivo no existe, la alerta sonora se cubre con el
sonido de la notificación del sistema operativo (canal de alta importancia).

Este README mantiene el directorio de assets bajo control de versiones.
