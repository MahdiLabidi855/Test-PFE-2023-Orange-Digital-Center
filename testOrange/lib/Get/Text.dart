import 'package:flutter/material.dart';

class TextA extends StatelessWidget {
  TextA({Key? key, required this.text, required this.titre}) : super(key: key);
  final String text;
  final bool titre;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: titre? const Color(0xFFB20000):Colors.black));
  }
}
