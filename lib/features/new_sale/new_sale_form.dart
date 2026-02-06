import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';

class NewSaleForm extends StatefulWidget {
  const NewSaleForm({super.key});

  @override
  State<NewSaleForm> createState() => _NewSaleFormState();
}

class _NewSaleFormState extends State<NewSaleForm> {
  ProductModel? selectedProduct;
  int quantity = 1;
  String paymentMethod = 'Cash';

  double get totalPrice => (selectedProduct?.price ?? 0) * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NOUVELLE VENTE")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 16,
          children: [
            const Text(
              "SÉLECTIONNER UN PRODUIT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // CES DONNEES VIENDRONT DE LA PARTIE ADMIN, MAIS ICI NOUS ALLONS UTILISER UN MOCK DATA
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ProductModel>(
                  isExpanded: true,
                  value: selectedProduct,
                  hint: const Text("Choisir un téléphone"),
                  items: productMockData.map((p) {
                    return DropdownMenuItem(value: p, child: Text(p.name));
                  }).toList(),
                  onChanged: (val) => setState(() => selectedProduct = val),
                ),
              ),
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      const Text(
                        "QUANTITÉ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: "1"),
                        onChanged: (val) {
                          setState(() => quantity = int.tryParse(val) ?? 1);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      const Text(
                        "PRIX UNITAIRE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${selectedProduct?.price.toStringAsFixed(0) ?? 0} CDF",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "TOTAL: ${totalPrice.toStringAsFixed(0)} CDF",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              "MODE DE PAIEMENT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Cash', 'Carte', 'Mobile Money'].map((mode) {
                bool isSelected = paymentMethod == mode;
                return GestureDetector(
                  onTap: () => setState(() => paymentMethod = mode),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      mode,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              height: 55,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Action pour SQLite
                  if (selectedProduct != null) {
                    final salesProvider = context.read<SalesProvider>();
                    salesProvider.saveSale(selectedProduct!, paymentMethod);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Vente de: ${selectedProduct?.name} - $totalPrice CDF enregistrée localement!",
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Veuillez entrer tous les détails"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Enregistrer la vente",
                  style: TextStyle(fontSize: 16, letterSpacing: 1.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
