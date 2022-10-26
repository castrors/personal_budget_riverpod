import 'package:go_router/go_router.dart';

import 'presentation/record_details_page.dart';
import 'presentation/record_list_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
        path: '/',
        builder: (context, state) => const RecordListPage(),
        routes: [
          GoRoute(
            path: 'details/:id',
            builder: (context, state) =>
                RecordDetailsPage(recordId: state.params['id']!),
          ),
        ]),
  ],
);
