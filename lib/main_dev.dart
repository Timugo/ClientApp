import 'package:flutter/material.dart';
import 'resources/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
    appTitle: "Flutter Dev Mode",
    url: 'http://167.172.216.181:3000/',
    child: MyApp(),
  );
  return runApp(configuredApp);
}