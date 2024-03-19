import 'package:flutter_deep_dive/product/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'basket_models.g.dart';

@JsonSerializable()
class BasketItemModel {
  final ProductModel product;
  final int count;

  BasketItemModel({
    required this.product,
    required this.count,
  });

  BasketItemModel copyWith({ProductModel? product, int? count}) =>
      BasketItemModel(
          product: product ?? this.product, count: count ?? this.count);

  factory BasketItemModel.fromJson(Map<String, dynamic> json) =>
      _$BasketItemModelFromJson(json);
}

@JsonSerializable()
class PatchBasketBodyModel {
  List<PatchBasketBodyBasketModel> basket;

  PatchBasketBodyModel({required this.basket});

  Map<String, dynamic> toJson() => _$PatchBasketBodyModelToJson(this);
}

@JsonSerializable()
class PatchBasketBodyBasketModel {
  final String productId;
  final int count;

  PatchBasketBodyBasketModel({
    required this.productId,
    required this.count,
  });

  Map<String, dynamic> toJson() => _$PatchBasketBodyBasketModelToJson(this);

  factory PatchBasketBodyBasketModel.fromJson(Map<String, dynamic> json) =>
      _$PatchBasketBodyBasketModelFromJson(json);
}
