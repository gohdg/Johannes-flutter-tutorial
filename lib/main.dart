import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_examples/formatter/max_lines_formatter.dart';

import 'formatter/max_length_in_line_formatter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: buildTextField(),
          )
        ],
      ),
    );
  }
}

final int maxLength = 120;
final int maxLengthInLine = 10;
final int maxLines = 5;
final int maxLinesForced = 3;

Widget buildTextField() {
  return Builder(
    builder: (context) => TextField(
      textInputAction: TextInputAction.newline,
      autofocus: true,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: maxLines,
      inputFormatters: [
        MaxLinesTextInputFormatter(maxLinesForced, () {
          showSnackBar(context, 'Only $maxLinesForced line breaks are allowed');
        }),
        MaxLengthPerLineFormatter(maxLengthInLine, () {
          showSnackBar(context, 'Only $maxLengthInLine characters are allowed');
        })
      ],
      style: TextStyle(
        fontSize: 22,
      ),
      decoration: InputDecoration(
        border: border(),
      ),
    ),
  );
}

InputBorder border() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(width: 0, color: Colors.transparent),
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
