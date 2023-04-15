import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_listing/core/enum/enum.dart';
import 'package:product_listing/feature/product/data/repository/product_repository_impl.dart';
import 'package:product_listing/feature/product/domain/model/model.dart';
import 'package:product_listing/feature/product/presentation/blocs/product/product_bloc.dart';
import 'package:test/test.dart';

List<Product> mockedProducts(int length) =>
    List.generate(length, (index) => Product(id: index));

class MockProductRepository extends Mock implements ProductRepositoryImpl {
  @override
  Future<List<Product>> getProducts([int? startIndex]) async {
    return await Future.value(mockedProducts(10));
  }
}

void main() async {
  group('ProductBloc', () {
    late ProductBloc bloc;
    late ProductRepositoryImpl repository;

    setUp(() {
      repository = MockProductRepository();
      bloc = ProductBloc(repository: repository);
    });

    test('initial state is ProductState()', () {
      expect(bloc.state, const ProductState());
    });

    group('GetProducts Event', () {
      blocTest<ProductBloc, ProductState>(
        'Products fetched should be limited to 10',
        build: () => bloc,
        act: (bloc) => bloc.add(GetProducts()),
        expect: () => [
          ProductState(
            status: Status.success,
            products: mockedProducts(10),
            hasReachedMax: false,
          )
        ],
      );

      tearDown(() {
        bloc.close();
      });
    });
  });
}
