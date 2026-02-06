import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<UserProvider>().name.isNotEmpty
        ? context.watch<UserProvider>().name
        : context.read<AuthProvider>().nameCtr;
    final dateOfToday = DateTime.now();
    final frenchMonths = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre',
    ];
    final frenchWeekdays = [
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi',
      'Dimanche',
    ];
    String formattedDateFr =
        "${frenchWeekdays[dateOfToday.weekday - 1]}, "
        "${dateOfToday.day.toString().padLeft(2, '0')} "
        "${frenchMonths[dateOfToday.month - 1]} "
        "${dateOfToday.year}";

    final menusLabels = [
      "CHIFFRE D'AFFAIRES", // montant total
      "NOMBRE DE VENTES", // total des transactions.
      "TOP PRODUIT", // produit le plus vendu
      "DERNIÈRE SYNCHRO", // Heure de la dernière synchronisation
    ];
    final menusContents = ["1.5M CDF", "200", "Google Pixel", "23h00"];
    final menusSubContents = ["", "", "", "7"];
    return Column(
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text("${getGreeting()},", style: TextStyle(fontSize: 30)),
            Text(
              "$userName 👋🏾",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              spacing: 16,
              children: [Text(formattedDateFr), Icon(Icons.cloud_outlined)],
            ),
          ],
        ),
        Text(
          "Voici la situation actuel de votre caisse",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Card(
                color: Theme.of(context).colorScheme.inverseSurface,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      child: Column(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .center,
                        children: [
                          Text(
                            menusLabels[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            menusContents[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            index == 3
                                ? "⚠️ ${menusSubContents[index]}\nnon-synchronisé"
                                : menusSubContents[index],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => NewSaleForm()),
      //     );
      //   },
      //   icon: Icon(Icons.add_rounded),
      //   label: Text("Nouveau"),
      // ),
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) {
      return "Bonjour";
    } else if (hour >= 12 && hour < 18) {
      return "Bon après-midi";
    } else if (hour >= 18 && hour < 23) {
      return "Bonsoir";
    } else {
      return "Salut";
    }
  }
}
