import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/models/pagination_params.dart';
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
    final notifier = RestaurantStateNotifier(repo: repository);
    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repo;

  RestaurantStateNotifier({
    required this.repo,
  }) : super(CursorPaginationLoading()) {
    getRestaurant();
  }

  Future<void> getRestaurant({
    int fetchAmount = 20,
    bool fetchMore = false,
    bool isReFetch = false,
  }) async {
    // 1.CursorPagination
    // 2.CursorPaginationLoading
    // 3.CursorPaginationError
    // 4.CursorPaginationRefetching
    // 4.CursorPaginationFetchMore

    // 바로 반환시 ->
    try {
      if (state is CursorPagination && !isReFetch) {
        final pState = state as CursorPagination;
        // 1
        if (!pState.meta.hasMore!) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }
      //<- 바로 반환시

      //다음페이지로 이동
      PaginationParams paginationParams = PaginationParams(count: fetchAmount);
      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      if (state is CursorPagination && isReFetch) {
        final pState = state as CursorPagination;
        state = CursorPaginationRefetching(
          data: pState.data,
          meta: pState.meta,
        );
      }
      final resp =
          await repo.getRestaurants(paginationParams: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        state = resp.copyWith(data: [
          ...pState.data,
          ...resp.data,
        ]);
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했어요 ㅜ');
    }
  }

  void getRestaurantDetail({
    required String id,
})async{
    if (state is !CursorPagination){
      await getRestaurant();
    }
    if (state is !CursorPagination){
      return;
    }
    final pState = state as CursorPagination;

    final resp = await repo.getRestaurantDetail(id: id);

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
