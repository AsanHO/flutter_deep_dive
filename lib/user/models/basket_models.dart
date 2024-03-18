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
  final String productId;
  final int count;

  PatchBasketBodyModel({
    required this.productId,
    required this.count,
  });

Map<String,dynamic> toJson() => _$PatchBasketBodyModelToJson(this);

}