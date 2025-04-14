import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart'
    show AnimationType, PinCodeFieldShape, PinCodeTextField, PinTheme;

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      obscureText: false,
      animationType: AnimationType.fade,
      cursorColor: Color(0xFFDA9220),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 70,
        fieldWidth: 70,
        activeColor: Colors.grey,
        inactiveColor: Colors.grey,
        selectedColor: Color(0xFFDA9220),
        borderWidth: 1,
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {},
    );
  }
}
