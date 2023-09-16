import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final showLoaderProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context) {
    bool showLoader = ref.watch(showLoaderProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Show/Hide Loader"),
      ),
      body: Stack(children: [
        Center(
            child: ElevatedButton(
                onPressed: () {
                  ref.read(showLoaderProvider.notifier).state = true;
                },
                child: const Text("Show Loader"))),
        Visibility(visible: showLoader, child: const Center(child: CircularProgressIndicator()))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(showLoaderProvider.notifier).state = false;
        },
        tooltip: 'Stop Loader',
        child: const Icon(Icons.close),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
