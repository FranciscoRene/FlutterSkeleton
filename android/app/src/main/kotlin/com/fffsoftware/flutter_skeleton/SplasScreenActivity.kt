package com.fffsoftware.flutter_skeleton

import android.content.Context
import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen

class SplasScreenActivity : FlutterActivity(), SplashScreen {
    override fun provideSplashScreen(): SplashScreen? {
        return super.provideSplashScreen()
    }

    override fun createSplashView(context: Context, savedInstanceState: Bundle?): View? {
        return null
    }

    override fun transitionToFlutter(onTransitionComplete: Runnable) {}
}