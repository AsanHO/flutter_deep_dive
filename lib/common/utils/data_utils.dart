import 'package:flutter_deep_dive/common/const/environments.dart';

class DataUtils{
  static String pathToUrl(String value) {
    return '$IP/$value';
  }

  static List<String> ListPathToUrls(List<String> paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}