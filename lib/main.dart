import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Random Messages App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNextWord() {
    current = WordPair.random();
    notifyListeners(); /* informa para os "ouvintes" do estado que é para atualizar o valor */
  }

}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Column(
        children: [
          BigCard(pair: pair),
          ElevatedButton(
            onPressed: () => appState.getNextWord(),
            child: Text("Next"),
          )
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard ({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    
    return Card (
      elevation: 5,
      shadowColor: Colors.indigo[900],
      color: theme.colorScheme.primary,
      child: Padding (
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase, style: textStyle),
      ),
    );
  }
}
