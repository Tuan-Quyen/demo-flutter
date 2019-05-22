package com.demo.flutter_app;

import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Environment;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "samples.flutter.io/files";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            (call, result) -> {
              if (call.method.equals("getImages")) {
                List<String> imgs = getImages();
                if (imgs.size() <= 0) {
                  result.error("Empty", "No Images.", null);
                } else {
                  result.success(imgs);                      }
              } else {
                result.notImplemented();
              }

            });
  }

  private List<String> getImages(){
    String path = Environment.getExternalStorageDirectory().toString()+"/Pictures";

    List<String> imgs;
    File directory = new File(path);
    imgs = Arrays.asList(directory.list());
    return imgs;
  }
}
