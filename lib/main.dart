import 'package:flutter/material.dart';
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
  MyApp({super.key}) {
    debugPrint('MyApp');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}

class Parent extends StatefulWidget {
  Parent({super.key}) {
    debugPrint('Parent');
  }

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  @override
  void initState() {
    debugPrint('Parent initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Parent build');
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => context.go('/child'),
          child: const Text('Go to child'),
        ),
      ),
    );
  }
}

class Child extends StatefulWidget {
  Child({super.key}) {
    debugPrint('Child');
  }

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
          onPressed: () => context.go('/child/grandchild'),
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
          onPressed: () => context.go('/'),
          child: const Text('Go to Parent'),
        ),
      ),
    );
  }
}
