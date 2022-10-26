import 'package:personal_budget/data/record_repository.dart';
import 'package:personal_budget/data/record_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'record.dart';

part 'providers.g.dart';

@riverpod
RecordRepository recordRepository(RecordRepositoryRef ref) =>
    RecordRepositoryImpl();

@riverpod
class RecordService extends _$RecordService {
  @override
  Future<List<Record>> build() async {
    return ref.watch(recordRepositoryProvider).getAllRecords();
  }

  Future<void> saveRecord(Record record) async {
    ref.read(recordRepositoryProvider).addRecord(record);
    ref.invalidateSelf();
    ref.invalidate(recordRepositoryProvider);
  }

  Future<void> updateRecord(Record record) async {
    ref.read(recordRepositoryProvider).updateRecord(record);
  }

  Future<void> deleteRecord(String recordId) async {
    ref.read(recordRepositoryProvider).deleteRecord(recordId);
  }

  Future<Record> getRecord(String id) async {
    return ref.read(recordRepositoryProvider).getRecord(id);
  }
}
