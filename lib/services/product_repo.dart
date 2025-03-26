import 'package:dio/dio.dart';
import 'package:shopping_cart_app/models/product.dart';

class ProductRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  Future<ProductResponse> fetchProducts({int skip = 0, int limit = 10}) async {
    try {
      final response = await _dio.get(
        '/products',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
