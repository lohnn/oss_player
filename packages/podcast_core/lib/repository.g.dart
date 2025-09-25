// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(repository)
const repositoryProvider = RepositoryProvider._();

final class RepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Repository>,
          Repository,
          FutureOr<Repository>
        >
    with $FutureModifier<Repository>, $FutureProvider<Repository> {
  const RepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'repositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$repositoryHash();

  @$internal
  @override
  $FutureProviderElement<Repository> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Repository> create(Ref ref) {
    return repository(ref);
  }
}

String _$repositoryHash() => r'24d4a964608e5f245038ada884aa1a6b6f42bf9a';
