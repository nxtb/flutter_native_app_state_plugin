package asia.ivity.flutter_native_app_state

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutterNativeAppStatePlugin */
public class FlutterNativeAppStatePlugin : FlutterPlugin {
    private lateinit var channel: EventChannel

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val instance = FlutterNativeAppStatePlugin()
            instance.startListening(registrar.messenger())
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        startListening(flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setStreamHandler(null)
    }

    private fun startListening(messenger: BinaryMessenger) {
        channel = EventChannel(messenger, "flutter_native_app_state/events")
        channel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                events?.success(0)
            }

            override fun onCancel(arguments: Any?) {
            }
        })
    }
}
