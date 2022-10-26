import 'package:personal_budget/data/record.dart';

abstract class RecordRepository {
  Future<List<Record>> getAllRecords();
  Future<Record> getRecord(String id);
  void addRecord(Record record);
  void updateRecord(Record record);
  void deleteRecord(String recordId);
}
