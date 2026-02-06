class SaleModel {
  final int? id;
  final String productName;
  final double amount;
  final DateTime date;
  final String category;

  SaleModel({
    this.id,
    required this.productName,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'amount': amount,
      'date': date.toIso8601String(), // Stockage sous forme de texte ISO
      'category': category,
    };
  }

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      id: map['id'],
      productName: map['productName'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }
}
