import 'package:freezed_annotation/freezed_annotation.dart';

part 'record.freezed.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required String id,
    required double value,
    required String description,
    required String category,
    required DateTime date,
    required String type,
    required String paymentMethod,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
        id: json['id'] ?? '0',
        value: double.tryParse(json['value']) ?? 0.0,
        description: json['description'] as String,
        category: json['category'] as String,
        date: DateTime.parse(json['date'] as String),
        type: json['type'] as String,
        paymentMethod: json['paymentMethod'] as String);
  }
}
