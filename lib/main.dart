import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
      ),
      home: const MyHomePage(title: '计算器'),
    );
  }
}

// home
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  '$_counter',
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _CalculatorKeyboard(),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// _CalculatorKeyboard
class _CalculatorKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 500,
      child: _CalculatorItem(),
    );
  }
}

// btn
class _CalculatorItem extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color color;
  final Color highlightColor;
  final double width;
  final ValueChanged<String> onValueChange;

  const _CalculatorItem(
      {required this.text,
      required this.textColor,
      required this.color,
      required this.highlightColor,
      required this.width,
      required this.onValueChange});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(200),
        ),
      ),
      child: InkWell(
        onTap: () {
          onValueChange('999999');
        },
      ),
    );
  }
}
