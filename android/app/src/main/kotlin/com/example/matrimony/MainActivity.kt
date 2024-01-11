package com.example.matrimony

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {


    private val VPN_CHANNEL = "method.com/vpn"


    private lateinit var vpnChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)


        vpnChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, VPN_CHANNEL)

        vpnChannel.setMethodCallHandler { call, result ->
            if (call.method == "isVpnConnected") {
                val isVpnConnected = isVpnConnected()
                result.success(isVpnConnected)
            }
        }
    }


    private fun isVpnConnected(): Boolean {
        try {
            val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val networks = connectivityManager.allNetworks

            for (network in networks) {
                val networkInfo = connectivityManager.getNetworkInfo(network)
                if (networkInfo?.typeName.equals("VPN", ignoreCase = true)) {
                    return true
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return false
    }

}