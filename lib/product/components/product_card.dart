import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/const/colors.dart';
import 'package:flutter_deep_dive/product/models/product_model.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_detail_model.dart';

import '../../common/const/environments.dart';

class ProductCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.detail,
    required this.price,
  });
  factory ProductCard.fromProductModel({
    required ProductModel model,
  }) {
    return ProductCard(
      imgUrl: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }
  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      imgUrl: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            child: Image.network(
              imgUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  detail,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '${price} 원',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
