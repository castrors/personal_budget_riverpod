// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String $RecordServiceHash() => r'2399fd81b9b20cec840576ae08d4865c9a9873b0';

/// See also [RecordService].
final recordServiceProvider =
    AutoDisposeAsyncNotifierProvider<RecordService, List<Record>>(
  RecordService.new,
  name: r'recordServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $RecordServiceHash,
);
typedef RecordServiceRef = AutoDisposeAsyncNotifierProviderRef<List<Record>>;

abstract class _$RecordService extends AutoDisposeAsyncNotifier<List<Record>> {
  @override
  FutureOr<List<Record>> build();
}

String $recordRepositoryHash() => r'1d2bea658dcebd03035f2a176c9778c07d4d0262';

/// See also [recordRepository].
final recordRepositoryProvider = AutoDisposeProvider<RecordRepository>(
  recordRepository,
  name: r'recordRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $recordRepositoryHash,
);
typedef RecordRepositoryRef = AutoDisposeProviderRef<RecordRepository>;
