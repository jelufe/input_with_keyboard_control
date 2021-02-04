# input_with_keyboard_control

The package provides an input that you can control whether the keyboard will show or not 
without losing focus, ideal for use with a barcode scanner!

## Example
<br />
Check example folder for code sample
<br /><br />
<img src="https://drive.google.com/u/1/uc?id=1n77fXgLZJP0onLrT3tFE4HaQiwf5jFiF&export=download" width="210" height="380"/>
<br /><br />

## Usage

<br />

1. Follow the install [guide](https://pub.dev/packages/input_with_keyboard_control/install)

<br />

2. Import the library:

```dart
import 'package:input_with_keyboard_control/input_with_keyboard_control.dart';
```
<br />

3. Add InputWithKeyboardControl widget in your code as in the example below

```dart
InputWithKeyboardControl(
  focusNode: InputWithKeyboardControlFocusNode(),
  onSubmitted: (value) {
    print(value);
  },
  autofocus: true,
  controller: TextEditingController(),
  width: 300,
  startShowKeyboard: false,
  buttonColorEnabled: Colors.blue,
  buttonColorDisabled: Colors.black,
  underlineColor: Colors.black,
  showUnderline: true,
  showButton: true,
)
```

<br /><br />
Thank you for using this package :heart:
<br /><br /><br />
