  
import 'package:flutter/material.dart';
import 'resources/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
    appTitle: "Flutter Production Mode",
    url: 'https://www.timugo.tk/',
    child: MyApp(),
  );
  return runApp(configuredApp);
}