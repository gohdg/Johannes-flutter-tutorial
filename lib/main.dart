import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_examples/color_filters.dart';
import 'package:image_picker/image_picker.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Basic Photo Filters'),
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
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: pickImage, icon: Icon(Icons.add_a_photo))
        ],
      ),
      body: ColorFiltered(
        colorFilter: ColorFilters.invert, // png 파일 transparency 적용된 경우 유용
        // ColorFilter.mode(Colors.black, BlendMode.color),
        child: buildImage(),
      ),
    );
  }

  Future pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        this.imageBytes = File(image.path).readAsBytesSync();
      }
    });
  }

  Widget buildImage() {
    return imageBytes != null ? Image.memory(imageBytes!) : Container();
  }
}
