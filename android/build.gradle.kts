allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Workaround para isar_flutter_libs 3.1.0+1 (paquete antiguo):
    //  - No declara `namespace` (requisito de AGP 8+) → se inyecta.
    //  - Declara compileSdkVersion 30, pero sus dependencias androidx usan
    //    `android:attr/lStar` (API 31+), lo que rompe el link de recursos en
    //    release → se sube el compileSdk.
    // Se registra ANTES de evaluationDependsOn para que aún no esté evaluado.
    if (project.name == "isar_flutter_libs") {
        afterEvaluate {
            project.extensions.findByName("android")?.withGroovyBuilder {
                "compileSdkVersion"(34)
                if (getProperty("namespace") == null) {
                    setProperty("namespace", "dev.isar.isar_flutter_libs")
                }
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
