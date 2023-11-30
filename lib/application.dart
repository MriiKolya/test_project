import 'package:flutter/material.dart';
import 'package:testproject/config/router/router.dart';
import 'package:testproject/config/theme/theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme(),
      routes: router,
    );
  }
}
