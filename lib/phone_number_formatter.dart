import 'dart:math';
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.length <= 1) {
      return newValue;
    }
    final formattedText =
        "(+66) ${text.substring(1, min(text.length, 3))} ${text.length > 3 ? text.substring(3, min(text.length, 6)) : ''}${text.length > 6 ? ' ${text.substring(6)}' : ''}";
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
