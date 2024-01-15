import 'package:flutter_riverpod/flutter_riverpod.dart';

final numProvider = StateProvider<int>((ref) => 0);
// 상태명 = StateProvider<상태타입>((ref)=>초기값);