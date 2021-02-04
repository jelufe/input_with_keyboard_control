library input_with_keyboard_control;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWithKeyboardControl extends EditableText {

  /// startShowKeyboard is initial value to show or not the keyboard when the widget is created
  /// Default value is false
  final bool startShowKeyboard;

  /// focusNode is responsible for controlling the focus of the field
  /// This parameter is required
  final InputWithKeyboardControlFocusNode focusNode;

  /// width is responsible for set the widget size
  /// This parameter is required
  final double width;

  /// buttonColorEnabled is responsible for set color in button when is enabled
  /// Default value is Colors.blue
  final Color buttonColorEnabled;

  /// buttonColorDisabled is responsible for set color in button when is disabled
  /// Default value is Colors.black
  final Color buttonColorDisabled;

  /// underlineColor is responsible for set color in underline BorderSide
  /// Default value is Colors.black
  final Color underlineColor;

  /// showUnderline is responsible for showing or not the underline in the widget
  /// Default value is true
  final bool showUnderline;

  /// showButton is responsible for showing or not the button to control the keyboard
  /// Default value is true
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
    this.underlineColor = Colors.black,
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
    return InputWithKeyboardControlState(
        startShowKeyboard,
        focusNode,
        width,
        buttonColorEnabled,
        buttonColorDisabled,
        underlineColor,
        showUnderline,
        showButton);
  }
}

class InputWithKeyboardControlState extends EditableTextState {
  
  /// showKeyboard is value responsible to show or not the keyboard
  /// Default value is false
  bool showKeyboard;

  /// focusNode is responsible for controlling the focus of the field
  /// This parameter is required
  final InputWithKeyboardControlFocusNode focusNode;

  /// width is responsible for set the widget size
  /// This parameter is required
  final double width;

  /// buttonColorEnabled is responsible for set color in button when is enabled
  /// Default value is Colors.blue
  final Color buttonColorEnabled;

  /// buttonColorDisabled is responsible for set color in button when is disabled
  /// Default value is Colors.black
  final Color buttonColorDisabled;

  /// underlineColor is responsible for set color in underline BorderSide
  /// Default value is Colors.black
  final Color underlineColor;

  /// showUnderline is responsible for showing or not the underline in the widget
  /// Default value is true
  final bool showUnderline;

  /// showButton is responsible for showing or not the button to control the keyboard
  /// Default value is true
  final bool showButton;

  InputWithKeyboardControlState(
      this.showKeyboard,
      this.focusNode,
      this.width,
      this.buttonColorEnabled,
      this.buttonColorDisabled,
      this.underlineColor,
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
                      borderSide: BorderSide(color: underlineColor))
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
