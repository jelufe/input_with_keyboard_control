library input_with_keyboard_control;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWithKeyboardControl extends EditableText {
  final bool showKeyboard;
  final InputWithKeyboardControlFocusNode focusNode;
  final double width;

  InputWithKeyboardControl({
    @required TextEditingController controller,
    TextStyle style = const TextStyle(color: Colors.black, fontSize: 18),
    Color cursorColor = Colors.black,
    bool autofocus = false,
    Color selectionColor,
    this.showKeyboard,
    void Function(String) onSubmitted,
    this.focusNode,
    this.width
  }):super(
    controller: controller,
    focusNode: focusNode,
    style: style,
    cursorColor: cursorColor,
    autofocus: autofocus,
    selectionColor: selectionColor,
    backgroundCursorColor: Colors.black,
    onSubmitted: onSubmitted
  );

  @override
  EditableTextState createState() {
    return InputWithKeyboardControlState(
      showKeyboard,
      focusNode,
      width
    );
  }

}

class InputWithKeyboardControlState extends EditableTextState {
  bool showKeyboard;
  final InputWithKeyboardControlFocusNode focusNode;
  final double width;

  InputWithKeyboardControlState(
    this.showKeyboard,
    this.focusNode,
    this.width
  );

  toggleShowKeyboard(bool value) {
    setState(() {
      showKeyboard = !value;
    });

    if (!showKeyboard) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      FocusScope.of(context).requestFocus(focusNode);
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.show');
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = super.build(context);
    return Container(
        width: width,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width - (width / 10),
            decoration: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.black)),
            child: widget
          ),
          InkWell(
              onTap: () {
                this.toggleShowKeyboard(showKeyboard);
              },
              child: Container(
              width: (width / 10),
              child: Icon(
                Icons.keyboard,
                color: showKeyboard ? Colors.blue : Colors.black,
              ),
            )
          )
        ],
      )
    );
  }

  @override
  void requestKeyboard() {
    super.requestKeyboard();
    
    if (!showKeyboard)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class InputWithKeyboardControlFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}