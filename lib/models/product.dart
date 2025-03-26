class ProductModel {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  final String thumbnail;
  final String brand;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
    required this.brand,
  });

  // Manual fromJson constructor
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String,
      brand: json['brand'] as String,
    );
  }

  double get discountedPrice => price - (price * discountPercentage / 100);
}

class ProductResponse {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      products:
          (json['products'] as List)
              .map((productJson) => ProductModel.fromJson(productJson))
              .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }
}
