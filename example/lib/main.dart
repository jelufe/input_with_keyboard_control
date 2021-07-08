import 'package:input_with_keyboard_control/input_with_keyboard_control.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input With Keyboard Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Input With Keyboard Control'),
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
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InputWithKeyboardControl(
              focusNode: InputWithKeyboardControlFocusNode(),
              onSubmitted: (value) {
                print(value);
              },
              autofocus: true,
              controller: textEditingController,
              width: 300,
              startShowKeyboard: false,
              buttonColorEnabled: Colors.blue,
              buttonColorDisabled: Colors.black,
              underlineColor: Colors.black,
              showUnderline: true,
              showButton: true,
            ),
          ],
        ),
      ),
    );
  }
}
