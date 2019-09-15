package com.example.flutter_app;

import android.content.Context;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;
import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), "mychannel")
        .setMethodCallHandler(new MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall methodCall, Result result) {
            if(methodCall.method.equals("toast")){
              try {
                Toast.makeText(MainActivity.this, "我是android", Toast.LENGTH_SHORT).show();
                result.success(0);
              } catch (Exception e) {
                e.printStackTrace();
                result.error("error","error",null);
              }
            }else {
              result.notImplemented();
            }
          }
        });


    Registrar registrar = registrarFor("nativeview");
    FlutterViewFactory flutterViewFactory = new FlutterViewFactory(registrar.messenger());
    registrar.platformViewRegistry().registerViewFactory("androidview",flutterViewFactory);
  }

  class FlutterViewFactory extends PlatformViewFactory{

    private final BinaryMessenger messenger;

    public FlutterViewFactory(BinaryMessenger messageCodec) {
      super(StandardMessageCodec.INSTANCE);
      messenger = messageCodec;
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
      return new FlutterView(context,i,messenger);
    }
  }

  class FlutterView implements PlatformView, MethodCallHandler {

    private final RelativeLayout view;

    private final MethodChannel channel;

    public FlutterView(Context context,int id,BinaryMessenger messenger) {
      channel = new MethodChannel(messenger,"nativeview_"+id);
      channel.setMethodCallHandler(this);

      this.view = new RelativeLayout(context);
      this.view.setBackgroundColor(Color.rgb(255,0,0));

      TextView tv = new TextView(context);
      tv.setText("from native");

      this.view.addView(tv);
      this.view.setGravity(Gravity.CENTER);
    }

    @Override
    public View getView() {
      return view;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {
      if(methodCall.method.equals("changeBackgroundColor")){
        int r = methodCall.argument("r");
        int g = methodCall.argument("g");
        int b = methodCall.argument("b");
        Log.e("android",String.valueOf(r));
        Log.e("android",String.valueOf(g));
        Log.e("android",String.valueOf(b));
        view.setBackgroundColor(Color.rgb(r,g,b));
        result.success(0);
      }else {
        result.notImplemented();
      }
    }
  }
}
