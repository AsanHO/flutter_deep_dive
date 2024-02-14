import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/dio/dio.dart';
import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/models/pagination_params.dart';
import 'package:flutter_deep_dive/restaurant/models/rating_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_rating_repository.g.dart';
final restaurantRatingRepositoryProvider = Provider.family<RestaurantRatingRepository,String>((ref,id) {
  final dio = ref.watch(dioProvider);
  
  return RestaurantRatingRepository(dio,baseUrl: '$IP/restaurant/$id/rating');
});
@RestApi()
abstract class RestaurantRatingRepository {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RatingModel>> getRating({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
