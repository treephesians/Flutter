import 'package:calendar/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  // true - 시간 / false - 내용
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  const CustomTextField(
      {super.key,
      required this.label,
      required this.isTime,
      required this.onSaved,
      required this.initialValue});

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
    return TextFormField(
      onSaved: onSaved,
      // null이 return되면 에러가 없다.
      // 에러가 있으면 에러를 String 값으로 리턴해준다.
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '값을 입력해주세요';
        }
        if (isTime) {
          int time = int.parse(val);
          if (time < 0) {
            return '0 이상의 숫자를 입력해주세요';
          }
          if (time > 24) {
            return '24 이하의 숫자를 입력해주세요';
          }
        } else {
          if (val.length > 500) {
            return '500자 이하의 글자를 입력해주세요';
          }
        }
      },
      cursorColor: Colors.grey,
      // 줄바꿈이 가능하다!
      maxLines: isTime ? 1 : null,
      //expands: !isTime,
      initialValue: initialValue,
      maxLength: 300,
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
        suffixText: isTime ? '시' : null,
      ),
    );
  }
}
