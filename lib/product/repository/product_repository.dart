import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/dio/dio.dart';
import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/models/pagination_params.dart';
import 'package:flutter_deep_dive/common/repository/base_pagination_repository.dart';
import 'package:flutter_deep_dive/product/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref){
  final dio = ref.watch(dioProvider);
  return ProductRepository(dio, baseUrl: '$IP/product');
});

@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<ProductModel>> paginate(
      {@Queries()
      PaginationParams? paginationParams = const PaginationParams()});
}
