import 'package:flutter_deep_dive/common/models/model_with_id.dart';
import 'package:flutter_deep_dive/common/utils/data_utils.dart';
import 'package:flutter_deep_dive/user/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId{
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(
    fromJson: DataUtils.ListPathToUrls,
  )
  final List<String> images;

  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.images,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
