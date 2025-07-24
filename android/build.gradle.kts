buildscript {
    repositories {
        google()
        mavenCentral()
        jcenter() // fallback
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.8.0")
        // other dependencies
    }
}
allprojects {
    repositories {
        google()
        mavenCentral()
        jcenter()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
