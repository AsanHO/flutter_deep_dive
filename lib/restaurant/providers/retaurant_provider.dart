import 'package:flutter_deep_dive/restaurant/models/restaurant_model.dart';
import 'package:flutter_deep_dive/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
        (ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repo: repository);
  return notifier;
},);

class RestaurantStateNotifier
    extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repo;

  RestaurantStateNotifier({
    required this.repo,
  }) : super([]) {
    getRestaurant();
  }

  getRestaurant() async {
    final resp = await repo.getRestaurants();

    state = resp.data;
  }
}
