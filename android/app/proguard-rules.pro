# Reglas R8/ProGuard del APK release.
#
# flutter_local_notifications serializa las notificaciones programadas con Gson,
# que depende de las firmas genéricas (TypeToken) en tiempo de ejecución. Sin
# estas reglas, R8 las elimina y la app crashea al dispararse la alerta de fin
# de ciclo (IllegalStateException: TypeToken must be created with a type argument).
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keep public class * implements java.lang.reflect.Type
-keep class com.dexterous.flutterlocalnotifications.** { *; }
