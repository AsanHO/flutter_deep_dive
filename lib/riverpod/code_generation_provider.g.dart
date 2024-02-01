// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_generation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gStateHash() => r'ea7d84571578f53984f0de1671c6c19f9219e440';

/// See also [gState].
@ProviderFor(gState)
final gStateProvider = AutoDisposeProvider<String>.internal(
  gState,
  name: r'gStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GStateRef = AutoDisposeProviderRef<String>;
String _$gStateFutureHash() => r'5c50928a01f8746011d0e3880012424d562bdd79';

/// See also [gStateFuture].
@ProviderFor(gStateFuture)
final gStateFutureProvider = AutoDisposeFutureProvider<int>.internal(
  gStateFuture,
  name: r'gStateFutureProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gStateFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GStateFutureRef = AutoDisposeFutureProviderRef<int>;
String _$gStateFutureAliveHash() => r'6707d26bf67d68ee784301925a08baf827880934';

/// See also [gStateFutureAlive].
@ProviderFor(gStateFutureAlive)
final gStateFutureAliveProvider = FutureProvider<int>.internal(
  gStateFutureAlive,
  name: r'gStateFutureAliveProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gStateFutureAliveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GStateFutureAliveRef = FutureProviderRef<int>;
String _$gStatefHash() => r'f2b199da67c201b6412d521ee0b8618c5a4594ee';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [gStatef].
@ProviderFor(gStatef)
const gStatefProvider = GStatefFamily();

/// See also [gStatef].
class GStatefFamily extends Family<int> {
  /// See also [gStatef].
  const GStatefFamily();

  /// See also [gStatef].
  GStatefProvider call({
    required int p1,
    required int p2,
  }) {
    return GStatefProvider(
      p1: p1,
      p2: p2,
    );
  }

  @override
  GStatefProvider getProviderOverride(
    covariant GStatefProvider provider,
  ) {
    return call(
      p1: provider.p1,
      p2: provider.p2,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'gStatefProvider';
}

/// See also [gStatef].
class GStatefProvider extends AutoDisposeProvider<int> {
  /// See also [gStatef].
  GStatefProvider({
    required int p1,
    required int p2,
  }) : this._internal(
          (ref) => gStatef(
            ref as GStatefRef,
            p1: p1,
            p2: p2,
          ),
          from: gStatefProvider,
          name: r'gStatefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gStatefHash,
          dependencies: GStatefFamily._dependencies,
          allTransitiveDependencies: GStatefFamily._allTransitiveDependencies,
          p1: p1,
          p2: p2,
        );

  GStatefProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.p1,
    required this.p2,
  }) : super.internal();

  final int p1;
  final int p2;

  @override
  Override overrideWith(
    int Function(GStatefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GStatefProvider._internal(
        (ref) => create(ref as GStatefRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        p1: p1,
        p2: p2,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _GStatefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GStatefProvider && other.p1 == p1 && other.p2 == p2;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, p1.hashCode);
    hash = _SystemHash.combine(hash, p2.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GStatefRef on AutoDisposeProviderRef<int> {
  /// The parameter `p1` of this provider.
  int get p1;

  /// The parameter `p2` of this provider.
  int get p2;
}

class _GStatefProviderElement extends AutoDisposeProviderElement<int>
    with GStatefRef {
  _GStatefProviderElement(super.provider);

  @override
  int get p1 => (origin as GStatefProvider).p1;
  @override
  int get p2 => (origin as GStatefProvider).p2;
}

String _$gStateNotifierHash() => r'3d6486fcf86fa1bf424a4de22190165fe7de3031';

/// See also [GStateNotifier].
@ProviderFor(GStateNotifier)
final gStateNotifierProvider =
    AutoDisposeNotifierProvider<GStateNotifier, int>.internal(
  GStateNotifier.new,
  name: r'gStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GStateNotifier = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
