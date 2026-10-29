class Service {
  final int id;
  final int companyId;
  final String name;
  final String description;
  final double price;

  Service({
    required this.id,
    required this.companyId,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'],
        companyId: json['companyId'],
        name: json['name'],
        description: json['description'] ?? '',
        // Prisma Decimal may arrive as a string, so parse safely
        price: double.tryParse(json['price'].toString()) ?? 0,
      );
}