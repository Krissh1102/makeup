import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/models/product.dart';
import 'package:shopping_cart_app/services/product_repo.dart';


final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) {
    return ProductsNotifier(ref.read(productRepositoryProvider));
  },
);

class ProductsState {
  final List<ProductModel> products;
  final bool isLoading;
  final int currentPage;
  final int totalProducts;
  final String? error;

  ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.currentPage = 0,
    this.totalProducts = 0,
    this.error,
  });

  ProductsState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    int? currentPage,
    int? totalProducts,
    String? error,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      totalProducts: totalProducts ?? this.totalProducts,
      error: error ?? this.error,
    );
  }
}

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductRepository _repository;

  ProductsNotifier(this._repository) : super(ProductsState()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await _repository.fetchProducts(
        skip: state.currentPage * 10,
        limit: 10,
      );

      state = state.copyWith(
        products: [...state.products, ...response.products],
        isLoading: false,
        currentPage: state.currentPage + 1,
        totalProducts: response.total,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
