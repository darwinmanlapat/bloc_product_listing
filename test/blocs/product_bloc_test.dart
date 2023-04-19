import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_listing/core/enum/enum.dart';
import 'package:product_listing/feature/product/domain/model/model.dart';
import 'package:product_listing/feature/product/domain/repository/repository.dart';
import 'package:product_listing/feature/product/presentation/blocs/product/product_bloc.dart';
import 'package:test/test.dart';

List<Product> mockedProducts({required int limit, int? length}) {
  if (length != null) {
    if (length <= limit) {
      return List.generate(length, (index) => Product(id: index));
    } else {
      return [];
    }
  }

  return [];
}

bool mockedHasReachedMax({required int limit, required int length}) =>
    length > limit;

class MockProductRepository extends Mock implements ProductRepository {
  @override
  Future<List<Product>> getProducts([int? startIndex]) async {
    final index = startIndex ?? 10;
    bool hasReachMax = mockedHasReachedMax(limit: 100, length: index + 10);

    return await Future.value(
        hasReachMax == true ? [] : mockedProducts(limit: 100, length: 10));
  }
}

void main() async {
  group('ProductBloc', () {
    late ProductBloc bloc;
    late ProductRepository repository;

    setUp(() {
      repository = MockProductRepository();
      bloc = ProductBloc(repository: repository);
    });

    test('initial state is ProductState()', () {
      expect(bloc.state, const ProductState());
    });

    group('GetProducts Event', () {
      const eventCount = 10;
      const limit = 100;

      blocTest<ProductBloc, ProductState>(
        'Products fetched should be limited to 10 per event',
        build: () => bloc,
        act: (bloc) {
          for (var i = 0; i < eventCount; i++) {
            bloc.add(GetProducts());
          }
        },
        expect: () => List.generate(
          eventCount,
          (index) => ProductState(
            status: Status.success,
            products:
                mockedProducts(limit: limit, length: (index + 1) * eventCount),
            hasReachedMax: mockedHasReachedMax(
                limit: limit, length: (index + 1) * eventCount),
          ),
        ),
      );

      blocTest<ProductBloc, ProductState>(
        'hasReachedMax property should be true when the total limit of the list is reached',
        build: () => bloc,
        act: (bloc) {
          bloc.add(GetProducts());
        },
        expect: () => [
          ProductState(
            status: Status.success,
            products: mockedProducts(limit: limit, length: 10),
            hasReachedMax: mockedHasReachedMax(limit: 10, length: 10),
          ),
        ],
      );
    });

    tearDown(() {
      bloc.close();
    });
  });
}
