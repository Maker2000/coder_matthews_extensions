package org.codemaker.coder_matthews_extensions

import android.app.Activity
import android.content.Context
import android.content.res.Configuration
import android.graphics.Point
import android.os.Build
import android.view.WindowManager
import androidx.window.layout.WindowMetricsCalculator

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.math.hypot

/** CoderMatthewsExtensionsPlugin */
class CoderMatthewsExtensionsPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private fun WindowManager.currentDeviceRealSize(): Pair<Int, Int> {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
      return Pair(
        maximumWindowMetrics.bounds.width(),
        maximumWindowMetrics.bounds.height())
    } else {
      val size = Point()
      @Suppress("DEPRECATION")
      defaultDisplay.getRealSize(size)
      Pair(size.x, size.y)
    }
  }

  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "coder_matthews_extensions")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "isTablet" -> {
        if((context.resources.configuration.screenLayout and Configuration.SCREENLAYOUT_SIZE_MASK) >= Configuration.SCREENLAYOUT_SIZE_LARGE){
          val (width, height) =  activity.windowManager.currentDeviceRealSize()
          val widthInInches: Double = (width / context.resources.displayMetrics.xdpi).toDouble()
          val heightInInches: Double = (height / context.resources.displayMetrics.ydpi).toDouble()
          result.success((if (widthInInches < heightInInches)  widthInInches else heightInInches) >=4.5)
        }else{
          result.success(false)
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
  }

}
