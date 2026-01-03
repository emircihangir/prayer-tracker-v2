// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Entries)
const entriesProvider = EntriesProvider._();

final class EntriesProvider
    extends $NotifierProvider<Entries, Map<String, Entry>> {
  const EntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entriesHash();

  @$internal
  @override
  Entries create() => Entries();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Entry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Entry>>(value),
    );
  }
}

String _$entriesHash() => r'4b3bb3150735c33783ee1ada4aacd2ec7edcca5f';

abstract class _$Entries extends $Notifier<Map<String, Entry>> {
  Map<String, Entry> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, Entry>, Map<String, Entry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, Entry>, Map<String, Entry>>,
              Map<String, Entry>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
