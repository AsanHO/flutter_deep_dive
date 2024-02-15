import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/dio/dio.dart';
import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/models/pagination_params.dart';
import 'package:flutter_deep_dive/common/repository/base_pagination_repository.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_detail_model.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return RestaurantRepository(dio, baseUrl: '$IP/restaurant');
});

@RestApi()
abstract class RestaurantRepository implements IBasePaginationRepository<RestaurantModel>{
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  ///일반화 했기 때문에 자동완성 paginate에 대해 지원됨
  // @override
  // Future<CursorPagination<IModelWithId>> paginate({PaginationParams? paginationParams = const PaginationParams()}) {
  //   // TODO: implement paginate
  //   throw UnimplementedError();
  // }
  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
