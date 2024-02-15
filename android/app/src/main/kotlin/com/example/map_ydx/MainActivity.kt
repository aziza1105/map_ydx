package com.example.map_ydx
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.engine.FlutterEngine
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("9b06e327-4adc-4938-b555-e71a4c7d6d61")
        super.configureFlutterEngine(flutterEngine)
    }
}
