import 'package:flutter/material.dart';
import 'package:qoutes_app/views/styles.dart';

class TextFields extends StatelessWidget {
  final TextEditingController textController;
  final String titleText;
  final int minLines;
  final int maxLines;
  bool obscureText;
  TextFields(
      {Key? key,
      required this.textController,
      required this.titleText,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: TextField(
            obscureText: obscureText,
            minLines: minLines,
            maxLines: maxLines,
            style: TextStyle(color: blackColor, fontSize: 15),
            cursorColor: blackColor,
            controller: textController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: darkGreyColor, width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              focusColor: blackColor,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blackColor, width: 0.0),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              labelText: titleText,
              labelStyle: TextStyle(color: blackColor, fontSize: 15),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
