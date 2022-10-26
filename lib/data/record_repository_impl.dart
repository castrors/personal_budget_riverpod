import 'package:gsheets/gsheets.dart';
import 'package:personal_budget/data/record.dart';
import 'package:personal_budget/data/record_repository.dart';

const _credentials = r'''
your_credentials
''';

const _spreadsheetId = 'your_spreadsheet_id';

class RecordRepositoryImpl implements RecordRepository {
  final gsheets = GSheets(_credentials);
  final Map<String, Record> _records = {};

  Future<Worksheet> _initializeSpreadSheet() async {
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = ss.worksheetByTitle('records');
    sheet ??= await ss.addWorksheet('records');
    return sheet;
  }

  @override
  Future<void> addRecord(Record record) async {
    final sheet = await _initializeSpreadSheet();

    final data = {
      'id': record.id,
      'description': record.description,
      'value': record.value,
      'category': record.category,
      'date': record.date.toIso8601String(),
      'type': record.type,
      'paymentMethod': record.paymentMethod,
    };
    await sheet.values.map.appendRow(data);
  }

  @override
  void deleteRecord(String recordId) async {
    final sheet = await _initializeSpreadSheet();

    final rowIndex = await sheet.values.rowIndexOf(recordId);
    await sheet.deleteRow(rowIndex);
    _records.remove(recordId);
  }

  @override
  Future<List<Record>> getAllRecords() async {
    final sheet = await _initializeSpreadSheet();

    final allRows = await sheet.values.map.allRows();
    final records =
        allRows?.map((json) => Record.fromJson(json)).toList() ?? [];
    _records
      ..clear()
      ..addEntries(
          records.map((record) => MapEntry(record.id.toString(), record)));
    return _records.values.toList();
  }

  @override
  Future<Record> getRecord(String id) {
    return Future.value(_records[id]);
  }

  @override
  void updateRecord(Record record) async {
    if (_records.containsKey(record.id)) {
      final sheet = await _initializeSpreadSheet();

      final data = [
        record.id,
        record.description,
        record.value,
        record.category,
        record.date.toIso8601String(),
        record.type,
        record.paymentMethod,
      ];
      await sheet.values.insertRowByKey(record.id, data, fromColumn: 1);

      _records[record.id] = record;
    }
  }
}
