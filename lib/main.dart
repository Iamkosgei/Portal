import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/logs/logs.dart';
import 'package:portal/core/routing/router.dart';
import 'package:portal/core/service_locator/get_it.dart';
import 'package:portal/core/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  setUpLoging();
  runApp(const MyApp());
}

final GoRouter appRouter = router();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Portal',
      theme: theme,
      themeMode: ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
