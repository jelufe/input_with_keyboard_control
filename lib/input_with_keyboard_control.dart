library input_with_keyboard_control;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWithKeyboardControl extends EditableText {
  final bool startShowKeyboard;
  final InputWithKeyboardControlFocusNode focusNode;
  final double width;
  final Color buttonColorEnabled;
  final Color buttonColorDisabled;
  final bool showUnderline;
  final bool showButton;

  InputWithKeyboardControl({
    @required TextEditingController controller,
    TextStyle style = const TextStyle(color: Colors.black, fontSize: 18),
    Color cursorColor = Colors.black,
    bool autofocus = false,
    Color selectionColor,
    this.startShowKeyboard = false,
    void Function(String) onSubmitted,
    @required this.focusNode,
    @required this.width,
    this.buttonColorEnabled = Colors.blue,
    this.buttonColorDisabled = Colors.black,
    this.showUnderline = true,
    this.showButton = true,
  }) : super(
          controller: controller,
          focusNode: focusNode,
          style: style,
          cursorColor: cursorColor,
          autofocus: autofocus,
          selectionColor: selectionColor,
          backgroundCursorColor: Colors.black,
          onSubmitted: onSubmitted,
        );

  @override
  EditableTextState createState() {
    return InputWithKeyboardControlState(startShowKeyboard, focusNode, width,
        buttonColorEnabled, buttonColorDisabled, showUnderline, showButton);
  }
}

class InputWithKeyboardControlState extends EditableTextState {
  bool showKeyboard;
  final InputWithKeyboardControlFocusNode focusNode;
  final double width;
  final Color buttonColorEnabled;
  final Color buttonColorDisabled;
  final bool showUnderline;
  final bool showButton;

  InputWithKeyboardControlState(
      this.showKeyboard,
      this.focusNode,
      this.width,
      this.buttonColorEnabled,
      this.buttonColorDisabled,
      this.showUnderline,
      this.showButton);

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
              width: showButton ? (width - (width / 9)) : width,
              decoration: showUnderline
                  ? UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.black))
                  : null,
              child: widget),
          showButton
              ? Row(
                  children: [
                    SizedBox(width: (width / 9) / 2),
                    InkWell(
                      onTap: () {
                        this.toggleShowKeyboard(showKeyboard);
                      },
                      child: Container(
                        width: (width / 9) / 2,
                        child: Icon(
                          Icons.keyboard,
                          color: showKeyboard
                              ? buttonColorEnabled
                              : buttonColorDisabled,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  void requestKeyboard() {
    super.requestKeyboard();

    if (!showKeyboard) SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class InputWithKeyboardControlFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
