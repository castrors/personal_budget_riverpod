import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/providers.dart';

class RecordListPage extends HookConsumerWidget {
  const RecordListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(recordServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          ref.invalidate(recordServiceProvider);

          return ref.read(recordServiceProvider.future);
        },
        child: records.when(
          data: (records) {
            return ListView(
              children: [
                for (final record in records)
                  ListTile(
                    title: Text(record.description),
                    trailing: Text(record.value.toString()),
                    onTap: () => context.go('/details/${record.id}'),
                  )
              ],
            );
          },
          error: (err, stack) => Text('Err $err'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/details/${-1}');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
