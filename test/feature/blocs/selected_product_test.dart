import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_listing/core/enum/enum.dart';
import 'package:product_listing/feature/product/data/repository/product_repository_impl.dart';
import 'package:product_listing/feature/product/domain/model/model.dart';
import 'package:product_listing/feature/product/presentation/blocs/selected_product/selected_product_bloc.dart';
import 'package:test/test.dart';

const products = <Product>[
  Product(id: 1),
  Product(id: 2),
  Product(id: 3),
];

Product findProduct(int id) =>
    products.firstWhere((product) => product.id == id);

class MockProductRepository extends Mock implements ProductRepositoryImpl {
  @override
  Future<Product> getProductById(int id) async {
    return await Future.value(findProduct(id));
  }
}

void main() async {
  group('SelectedProductBloc', () {
    late SelectedProductBloc bloc;
    late ProductRepositoryImpl repository;

    setUp(() {
      repository = MockProductRepository();
      bloc = SelectedProductBloc(repository: repository);
    });

    test('initial state is SelectedProductState()', () {
      expect(bloc.state, const SelectedProductState());
    });

    group('GetProductById Event', () {
      blocTest<SelectedProductBloc, SelectedProductState>(
        'Product should be fetch',
        build: () => bloc,
        act: (bloc) => bloc.add(GetProductById(id: 1)),
        expect: () => [
          const SelectedProductState(),
          SelectedProductState(
            status: Status.success,
            product: findProduct(1),
          )
        ],
      );

    // TODO: Create a test checking if all fields are populated
    });
  });
}
