import 'package:flutter/material.dart';
import 'package:isystem/features/host_screen.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SalesProvider()),
      ],
      child: const ISystemApp(),
    ),
  );
}

class ISystemApp extends StatelessWidget {
  const ISystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    final generalProvider = Provider.of<GeneralProvider>(context);

    return MaterialApp(
      title: 'iSYSTEM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: generalProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HostScreen(),
    );
  }
}
