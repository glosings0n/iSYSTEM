import 'package:flutter/material.dart';
import 'package:isystem/features/auth/screens/auth_screen.dart';
import 'package:isystem/features/host_screen.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  // Récupère l'utilisateur courant (s'il existe)
  final currentUser = await DatabaseHelper.instance.getUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final up = UserProvider();
            if (currentUser != null) {
              up.setUser(
                currentUser['name'] as String,
                currentUser['email'] as String,
              );
            }
            return up;
          },
        ),
        ChangeNotifierProvider(create: (_) => SalesProvider()),
      ],
      child: ISystemApp(startOnHost: currentUser != null),
    ),
  );
}

class ISystemApp extends StatelessWidget {
  final bool startOnHost;

  const ISystemApp({super.key, this.startOnHost = false});

  @override
  Widget build(BuildContext context) {
    final generalProvider = Provider.of<GeneralProvider>(context);

    return MaterialApp(
      title: 'iSYSTEM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: generalProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: startOnHost ? const HostScreen() : const AuthScreen(),
    );
  }
}
