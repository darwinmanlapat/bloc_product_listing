part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  const ProductState({
    this.status = Status.initial,
    List<Product>? products,
    this.hasReachedMax = false,
  }) : products = products ?? const [];

  final List<Product> products;
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
