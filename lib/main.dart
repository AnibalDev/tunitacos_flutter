import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';
import 'package:tunitacos_flutter/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MongoRealmsConfig();
  runApp(const MyApp());
}
