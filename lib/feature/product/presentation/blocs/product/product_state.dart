part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState({
    this.status = Status.initial,
    List<Product>? products,
    Product? selectedProduct,
    this.hasReachedMax = false,
  })  : products = products ?? const [],
        selectedProduct = selectedProduct ?? const Product();

  final List<Product> products;
  final Product selectedProduct;
  final Status status;
  final bool hasReachedMax;

  ProductState copyWith({
    List<Product>? products,
    Status? status,
    bool? hasReachedMax,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ProductState { status: $status, hasReachedMax: $hasReachedMax, products: ${products.length} }''';
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax];
}
