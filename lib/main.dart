import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

late GoRouter router;

void main() {
  router = createRouter();
  runApp(MyApp());
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Parent(),
        routes: [
          GoRoute(
            path: 'child',
            builder: (context, state) => Child(),
            routes: [
              GoRoute(
                path: 'grandchild',
                builder: (context, state) => Grandchild(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: MaterialApp.router(routerConfig: router));
  }
}

Stream<int> getStream() {
  debugPrint('getStream called');
  return Stream.value(0);
}

final streamProvider = StreamProvider.autoDispose<int>((ref) {
  return getStream();
});

class Parent extends ConsumerStatefulWidget {
  const Parent({super.key});

  @override
  ConsumerState<Parent> createState() => _ParentState();
}

class _ParentState extends ConsumerState<Parent> {
  @override
  void initState() {
    super.initState();
    debugPrint('Parent initState');
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(streamProvider);
    debugPrint('Parent build');
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => context.push('/child'),
          child: const Text('Go to child'),
        ),
      ),
    );
  }
}

class Child extends StatefulWidget {
  const Child({super.key});

  @override
  State<Child> createState() => _ChildState();
}

class _ChildState extends State<Child> {
  @override
  void initState() {
    debugPrint('Child initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Child build');
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => context.push('/child/grandchild'),
          child: const Text('Go to grandchild'),
        ),
      ),
    );
  }
}

class Grandchild extends StatelessWidget {
  Grandchild({super.key}) {
    debugPrint('Grandchild');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Grandchild build');
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => context.push('/'),
          child: const Text('Go to Parent'),
        ),
      ),
    );
  }
}
