# input_with_keyboard_control

The package provides an input that you can control whether the keyboard will show or not 
without losing focus

## Example
<br />
<img src="https://drive.google.com/u/1/uc?id=1eHJfap6W2hlmhEWGHtSVkQh5MSKZuNUk&export=download" width="220" height="400"/>
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
    onSubmitted: (valor) {
        print(valor);
    },
    autofocus: true,
    controller: TextEditingController(),
    width: 300,
    showKeyboard: false
)
```
