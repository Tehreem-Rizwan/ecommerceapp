class Productt {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  Productt({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  // Factory constructor to create a Product object from Firestore data
  factory Productt.fromMap(Map<String, dynamic> data, String documentId) {
    return Productt(
      id: documentId,
      name: data['name'] ?? 'No Name',
      imageUrl: data['imageUrl'] ?? '', // Handle missing image URL
      price: (data['price'] ?? 0).toDouble(), // Ensure price is a double
    );
  }
}
