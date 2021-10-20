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
  late String _text = '0'; // 显示当前输入的数字和计算结果
  late String _beforeText = '0'; // 用于保存被加数
  late bool _isResult = false; // 当前值是否为计算的结果
  late String _operateText = ''; // 保存加减乘除

  void onValueChange(String value) {
    // ignore: avoid_print
    print(value);
    String tmpText = _text;
    String tmpBeforeText = _beforeText;
    bool tmpIsResult = _isResult;
    String tmpOperateText = _operateText;

    switch (value) {
      case 'AC':
        setState(() {
          _text = '0';
          _beforeText = '0';
          _isResult = false;
        });
        break;
      case '+/-':
        if (tmpText.startsWith('-')) {
          tmpText = tmpText.substring(1);
        } else {
          tmpText = '-$tmpText';
        }
        // 更新数据
        setState(() {
          _text = tmpText;
        });
        break;
      case '%':
        double d = _value2Double(tmpText);
        tmpIsResult = true;
        tmpText = '${d / 100.0}';
        // 更新数据
        setState(() {
          _text = tmpText;
          _isResult = tmpIsResult;
        });
        break;
      case '+':
      case '-':
      case 'x':
      case '÷':
        tmpIsResult = false;
        tmpOperateText = value;
        setState(() {
          _operateText = tmpOperateText;
          _isResult = tmpIsResult;
        });
        break;
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case '.':
        if (tmpIsResult) {
          tmpText = value;
        }
        if (tmpOperateText.isNotEmpty && tmpBeforeText.isEmpty) {
          tmpBeforeText = tmpText;
          tmpText = '';
        }
        tmpText += value;
        if (tmpText.startsWith('0')) {
          tmpText = tmpText.substring(1);
        }

        // 更新数据
        setState(() {
          _text = tmpText;
          _beforeText = tmpBeforeText;
        });
        break;
      case '=':
        double d = _value2Double(tmpBeforeText);
        double d1 = _value2Double(tmpText);

        switch (tmpOperateText) {
          case '+':
            tmpText = '${d + d1}';
            break;
          case '-':
            tmpText = '${d - d1}';
            break;
          case 'x':
            tmpText = '${d * d1}';
            break;
          case '÷':
            tmpText = '${d / d1}';
            break;
        }
        // 更新数据
        setState(() {
          _text = tmpText;
          _beforeText = '';
          _operateText = '';
          _isResult = true;
        });
        break;
      default:
        break;
    }
  }

  double _value2Double(String value) {
    if (value.startsWith('-')) {
      String s = value.substring(1);
      return double.parse(s) * -1;
    } else {
      return double.parse(value);
    }
  }

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
                  _text,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
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
            _CalculatorKeyboard(onValueChange: onValueChange),
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
