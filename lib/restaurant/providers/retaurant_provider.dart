import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/models/pagination_params.dart';
import 'package:flutter_deep_dive/common/providers/pagination_provider.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_model.dart';
import 'package:flutter_deep_dive/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDetailProvider = Provider.family<RestaurantModel?,String>((ref,id){
  final state = ref.watch(restaurantProvider);
  //실제로는 RestaurantModel을 상속한 RestaurantDetailModel이 들어있는경우 해당 로직을 통과하지 않음
  // 왜??
  if (state is CursorPagination<RestaurantModel>){
    return state.data.firstWhere((element) => element.id == id);
  }
  if (state is! CursorPagination) {
    return null;
  }
  return state.data.firstWhere((element) => element.id == id);
});


final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier extends PaginationProvider<RestaurantModel,RestaurantRepository> {

  RestaurantStateNotifier({
    required super.repository,
  });


  void getRestaurantDetail({
    required String id,
})async{
    if (state is !CursorPagination){
      await paginate();
    }
    if (state is !CursorPagination){
      return;
    }
    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
      data: pState.data.map<RestaurantModel>((e) {
        if (e.id == id){
          return resp;
        }
        return e;
      }).toList()
    ) ;

  }
}
