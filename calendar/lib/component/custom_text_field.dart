import 'package:calendar/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true - 시간 / false - 내용
  final bool isTime;
  const CustomTextField({super.key, required this.label, required this.isTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w600),
        ),
        if (isTime) renderTextField(),
        if (!isTime) renderTextField(),
      ],
    );
  }

  Widget renderTextField() {
    return Container(
      child: TextField(
        cursorColor: Colors.grey,
        // 줄바꿈이 가능하다!
        maxLines: isTime ? 1 : null,
        //expands: !isTime,
        keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
        inputFormatters: isTime
            ? [
                // 숫자만 들어가게끔!
                FilteringTextInputFormatter.digitsOnly,
              ]
            : [],
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300],
        ),
      ),
    );
  }
}
