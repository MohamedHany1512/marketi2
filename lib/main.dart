import 'package:flutter/material.dart';
import 'package:marketi/core/helper/cache_helper.dart';
import 'package:marketi/core/services/services_locator.dart';
import 'package:marketi/marketi_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper().init();

  setupServiceLocator();
  runApp(const MarketiApp());
}
