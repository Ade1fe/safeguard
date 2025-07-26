plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.safeguard" // Replace with your actual package name
    compileSdk = 35 // Correct assignment
    ndkVersion = "27.0.12077973" // Correct assignment

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    defaultConfig {
        applicationId = "com.example.safeguard" // Correct assignment
        minSdk = 23 // Explicitly set minSdk to 23
        targetSdk = 33 // Correct assignment
        versionCode = 1 // Correct assignment
        versionName = "1.0" // Correct assignment
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
        isMinifyEnabled = true // ✅ REQUIRED
        isShrinkResources = true // ✅ OPTIONAL, but only works if minify is also enabled
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
        signingConfig = signingConfigs.getByName("debug") // or your release config
      }
    }


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11 // Correct assignment and enum access
        targetCompatibility = JavaVersion.VERSION_11 // Correct assignment and enum access
    }

    kotlinOptions {
        jvmTarget = "11" // Correct assignment
    }
}

flutter {
    source = "../.." // Correct assignment
}

dependencies {
    // Dependencies are added using the 'implementation' function with parentheses
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.9.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}
