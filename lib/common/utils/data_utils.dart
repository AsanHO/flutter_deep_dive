import 'package:flutter_deep_dive/common/const/environments.dart';

class DataUtils{
  static String pathToUrl(String value) {
    return '$IP/$value';
  }
  static DateTime stringToDateTime(String value){
    return DateTime.parse(value);
  }
  static List<String> listPathToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}