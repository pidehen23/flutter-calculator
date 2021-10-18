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
        // primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: '计算器'),
    );
  }
}

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
        // decoration: const BoxDecoration(color: Colors.black12),
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
            _CalculatorKeyboard(onValueChange: (String str) {
              print(str);
            }),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 按钮组
class _CalculatorKeyboard extends StatelessWidget {
  final ValueChanged<String> onValueChange;
  final List<Map> _keyboardList = [
    {
      'text': 'AC',
      'textColor': Colors.black,
      'color': const Color(0xFFA5A5A5),
      'highlightColor': const Color(0xFFD8D8D8)
    },
    {
      'text': '+/-',
      'textColor': Colors.black,
      'color': const Color(0xFFA5A5A5),
      'highlightColor': const Color(0xFFD8D8D8)
    },
    {
      'text': '%',
      'textColor': Colors.black,
      'color': const Color(0xFFA5A5A5),
      'highlightColor': const Color(0xFFD8D8D8)
    },
    {
      'text': '÷',
      'color': const Color(0xFFE89E28),
      'highlightColor': const Color(0xFFEDC68F)
    },
    {'text': '7', 'color': const Color(0xFF363636)},
    {'text': '8', 'color': const Color(0xFF363636)},
    {'text': '9', 'color': const Color(0xFF363636)},
    {
      'text': 'x',
      'color': const Color(0xFFE89E28),
      'highlightColor': const Color(0xFFEDC68F),
    },
    {'text': '4', 'color': const Color(0xFF363636)},
    {'text': '5', 'color': const Color(0xFF363636)},
    {'text': '6', 'color': const Color(0xFF363636)},
    {
      'text': '-',
      'color': const Color(0xFFE89E28),
      'highlightColor': const Color(0xFFEDC68F)
    },
    {'text': '1', 'color': const Color(0xFF363636)},
    {'text': '2', 'color': const Color(0xFF363636)},
    {'text': '3', 'color': const Color(0xFF363636)},
    {
      'text': '+',
      'color': const Color(0xFFE89E28),
      'highlightColor': const Color(0xFFEDC68F)
    },
    {'text': '0', 'color': const Color(0xFF363636), 'width': 158.0},
    {'text': '.', 'color': const Color(0xFF363636)},
    {
      'text': '=',
      'color': const Color(0xFFE89E28),
      'highlightColor': const Color(0xFFEDC68F),
    },
  ];

  _CalculatorKeyboard({Key? key, required this.onValueChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 18,
      spacing: 18,
      children: List.generate(
        _keyboardList.length,
        (index) => _CalculatorItem(
          color: _keyboardList[index]['color'],
          text: _keyboardList[index]['text'],
          highlightColor: _keyboardList[index]['highlightColor'],
          width: _keyboardList[index]['width'],
          onValueChange: onValueChange,
        ),
      ),
    );
  }
}

// 按钮
class _CalculatorItem extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color color;
  final Color? highlightColor;
  final double? width;
  final ValueChanged<String> onValueChange;

  const _CalculatorItem(
      {required this.text,
      required this.color,
      required this.onValueChange,
      this.highlightColor,
      this.textColor,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(200)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(200)),
        highlightColor: highlightColor ?? color,
        onTap: () {
          onValueChange(text);
        },
        child: Container(
          width: width ?? 70,
          height: 70,
          padding: EdgeInsets.only(left: width == null ? 0 : 25),
          alignment: width == null ? Alignment.center : Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
