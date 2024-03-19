// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketItemModel _$BasketItemModelFromJson(Map<String, dynamic> json) =>
    BasketItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      count: json['count'] as int,
    );

Map<String, dynamic> _$BasketItemModelToJson(BasketItemModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'count': instance.count,
    };

PatchBasketBodyModel _$PatchBasketBodyModelFromJson(
        Map<String, dynamic> json) =>
    PatchBasketBodyModel(
      basket: (json['basket'] as List<dynamic>)
          .map((e) =>
              PatchBasketBodyBasketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatchBasketBodyModelToJson(
        PatchBasketBodyModel instance) =>
    <String, dynamic>{
      'basket': instance.basket,
    };

PatchBasketBodyBasketModel _$PatchBasketBodyBasketModelFromJson(
        Map<String, dynamic> json) =>
    PatchBasketBodyBasketModel(
      productId: json['productId'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$PatchBasketBodyBasketModelToJson(
        PatchBasketBodyBasketModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
    };
