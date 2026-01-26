import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_theme.dart';
import 'package:zendvo/core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Zendvo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
