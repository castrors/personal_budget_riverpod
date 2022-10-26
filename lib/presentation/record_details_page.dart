import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/providers.dart';
import '../data/record.dart';

class RecordDetailsPage extends ConsumerStatefulWidget {
  const RecordDetailsPage({super.key, required this.recordId});

  final String recordId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecordDetailsPageState();
}

class _RecordDetailsPageState extends ConsumerState<RecordDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  String _selectedDateTime = DateTime.now().toString();

  @override
  void initState() {
    if (widget.recordId != '-1') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateValues();
      });
    }

    super.initState();
  }

  Future<void> _updateValues() async {
    final record = await ref
        .watch(recordServiceProvider.notifier)
        .getRecord(widget.recordId);

    setState(() {
      _valueController.text = record.value.toString();
      _descriptionController.text = record.description;
      _categoryController.text = record.category;
      _paymentMethodController.text = record.paymentMethod;
      _selectedDateTime = record.date.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recordId),
        actions: [
          IconButton(
              onPressed: () async {
                await ref
                    .read(recordServiceProvider.notifier)
                    .deleteRecord(widget.recordId);

                ref.invalidate(recordServiceProvider);
                context.pop();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _valueController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
                labelText: 'Expense value',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the expense value';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.description),
                labelText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.category),
                labelText: 'Category',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the category';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _paymentMethodController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.payment),
                labelText: 'Payment method',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the payment method';
                }
                return null;
              },
            ),
            DateTimePicker(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.date_range),
                labelText: 'Date',
              ),
              initialValue: _selectedDateTime,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              onChanged: (val) {
                _selectedDateTime = val;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the date';
                }
                return null;
              },
              onSaved: (val) => print(val),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final isEditMode = widget.recordId != '-1';
              final record = Record(
                id: widget.recordId,
                value: double.parse(_valueController.text),
                description: _descriptionController.text,
                category: _categoryController.text,
                type: 'expense',
                paymentMethod: _paymentMethodController.text,
                date: DateTime.parse(_selectedDateTime),
              );
              if (isEditMode) {
                await ref
                    .read(recordServiceProvider.notifier)
                    .updateRecord(record);
              } else {
                await ref.read(recordServiceProvider.notifier).saveRecord(
                    record.copyWith(
                        id: DateTime.now().millisecondsSinceEpoch.toString()));
              }

              context.pop();
            }
          }),
    );
  }
}
