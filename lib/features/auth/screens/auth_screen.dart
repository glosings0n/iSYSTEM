import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:isystem/features/host_screen.dart';
import 'package:isystem/core/core.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final labelsText = ["Nom", "Email", "Password"];
    final icons = [
      AppIcons.name(context),
      AppIcons.email(context),
      AppIcons.password(context),
    ];
    final hintsText = ["Georges", "georges@isystem.com", "********"];
    final keyboardTypes = [
      TextInputType.text,
      TextInputType.emailAddress,
      TextInputType.text,
    ];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: 32,
            children: [
              Column(
                children: [
                  const Text("Bienvenue chez", style: TextStyle(fontSize: 24)),
                  const Text(
                    "iSystem",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 16,
                  children: List.generate(labelsText.length, (index) {
                    return TextFormField(
                      onChanged: (value) {
                        if (index == 0) {
                          authProvider.changeUserName(value);
                        }
                        if (index == 1) {
                          authProvider.changeUserEmail(value);
                        }
                        if (index == 2) {
                          authProvider.changeUserPassword(value);
                        }
                      },
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      keyboardType: keyboardTypes[index],
                      obscureText:
                          index == (labelsText.length - 1) &&
                          !authProvider.canViewPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: icons[index],
                        hintText: hintsText[index],
                        labelText: labelsText[index],
                        suffixIcon: index == (labelsText.length - 1)
                            ? IconButton(
                                onPressed: authProvider.changeViewPasswordState,
                                icon: AppIcons.viewPassword(
                                  context,
                                  canViewPassword: authProvider.canViewPassword,
                                ),
                              )
                            : null,
                      ),
                    );
                  }),
                ),
              ),
              FilledButton(
                onPressed: () {
                  if (authProvider.emailCtr.isNotEmpty &&
                      !authProvider.emailCtr.contains("@")) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Email incorrect")));
                    return;
                  }
                  if (authProvider.nameCtr.isNotEmpty &&
                      authProvider.emailCtr.isNotEmpty &&
                      authProvider.passwordCtr.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HostScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Veuillez entrer toutes les valeurs"),
                      ),
                    );
                  }
                },
                child: Text("Se connecter"),
              ),

              // ElevatedButton(
              //   onPressed: () => context.read<GeneralProvider>().toggleTheme(),
              //   child: const Text("Switch Theme"),
              // ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(text: "En continuant, vous acceptez nos "),
              TextSpan(
                text: "confidentialités",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(text: " et "),
              TextSpan(
                text: "termes de service",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(text: "."),
            ],
          ),
        ),
      ],
    );
  }
}
