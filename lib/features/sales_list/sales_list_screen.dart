import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/core.dart';

class SalesListPage extends StatefulWidget {
  const SalesListPage({super.key});

  @override
  State<SalesListPage> createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text("Vos ventes", style: TextStyle(fontSize: 30)),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              spacing: 4,
              children: [
                Text(
                  "STATUT CLOUD",
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "3/7 ventes synchronisées",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: .end,
          children: [
            ElevatedButton.icon(
              onPressed: _currentTabIndex != 0 ? () {} : null,
              icon: const Icon(Icons.sync),
              label: const Text("SYNCHRONISER TOUT"),
            ),
          ],
        ),
        TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurface.withAlpha(150),
          indicatorColor: theme.colorScheme.primary,

          tabs: const [
            Tab(text: "TOUTES"),
            Tab(text: "EN ATTENTE"),
          ],
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildSalesList(filterSynced: null),
              _buildSalesList(filterSynced: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSalesList({bool? filterSynced}) {
    final theme = Theme.of(context);

    return FutureBuilder<List<Map<String, dynamic>>>(
      // On appelle la fonction de lecture SQLite
      future: DatabaseHelper.instance.getAllSales(),
      builder: (context, snapshot) {
        // 1. Pendant le chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }

        // 2. En cas d'erreur ou si la liste est vide
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "Aucune vente enregistrée",
              style: theme.textTheme.bodyMedium,
            ),
          );
        }

        // 3. Filtrage des données SQLite (Toutes ou En attente)
        final allSales = snapshot.data!;
        final filteredList = filterSynced == null
            ? allSales
            : allSales
                  .where((s) => (s['isSynced'] == 1) == filterSynced)
                  .toList();

        if (filteredList.isEmpty) {
          return const Center(child: Text("Rien à afficher ici"));
        }

        // 4. Ta liste défilante originale utilisant les données de SQLite
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: filteredList.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (context, index) {
            final sale = filteredList[index];
            final bool isSynced = sale['isSynced'] == 1;

            // Parsing de la date stockée en String ISO8601 dans SQLite
            final DateTime date = DateTime.parse(sale['date']);

            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.circle,
                size: 12,
                color: isSynced ? Colors.green : Colors.orange,
              ),
              title: Text(
                "ID: #${sale['id']} - ${DateFormat('HH:mm').format(date)}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${sale['productName']}",
                style: theme.textTheme.bodySmall,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${sale['amount']} CDF",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!isSynced) ...[
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: () {
                        // Logique de modification
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: () async {
                        // Suppression réelle dans SQLite
                        await DatabaseHelper.instance.deleteSale(sale['id']);
                        setState(() {}); // Rafraîchit l'UI
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

final List<Map<String, dynamic>> mockSalesFromDb = [
  {
    'id': 1234,
    'productName': 'iPhone 15 Pro Max',
    'amount': 3500000.0,
    'date': '2026-02-06T12:20:00',
    'isSynced': 1, // Vert
  },
  {
    'id': 1235,
    'productName': 'Samsung Galaxy S24',
    'amount': 3200000.0,
    'date': '2026-02-06T14:45:00',
    'isSynced': 0, // Orange
  },
  // Ajoute d'autres entrées ici...
];
