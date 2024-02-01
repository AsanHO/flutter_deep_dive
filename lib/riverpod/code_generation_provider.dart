import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 프로바이더 사용할지 고민 할 필요가 없다.

final testProvider = Provider<String>((ref) => 'hello');

//일반적인 값
@riverpod
String gState(GStateRef ref) {
  return 'hello';
}

@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 6;
}

@Riverpod(keepAlive: true)
Future<int> gStateFutureAlive(GStateFutureAliveRef ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 6;
}

// 2) 패밀리 파라미터를 일반 함수처럼 만들 수 있다.
class Parameter {
  final p1;
  final p2;

  Parameter({
    required this.p1,
    required this.p2,
  });
}

final _testFamilyProvider = Provider.family<int, Parameter>(
    (ref, parameter) => parameter.p1 * parameter.p2);

@riverpod
int gStatef(
  GStatefRef ref, {
  required int p1,
  required int p2,
}) {
  return p1 * p2;
}


@riverpod
class GStateNotifier extends _$GStateNotifier{
  @override
  int build(){
    return 0;
  }

  inc(){
    state++;
  }

  dec(){
    state--;
  }
}