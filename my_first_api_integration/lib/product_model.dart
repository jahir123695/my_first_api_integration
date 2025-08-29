class ProductModel {
  int? id;
  String? title;
  String? price;
  String? description;
  String? category;
  String? image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  static ProductModel jsonToModel(Map<String, dynamic> data) {
    return ProductModel(
      id: data["id"],
      title: data["title"],
      price: data["price"].toString(),
      description: data["description"],
      category: data["category"],
      image: data["image"],
    );
  }
}
