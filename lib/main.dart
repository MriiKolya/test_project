import 'package:flutter/material.dart';
import 'package:testproject/application.dart';
import 'package:testproject/features/data/notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationApi.init();
  runApp(const Application());
}
