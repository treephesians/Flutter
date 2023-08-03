import 'package:flutter/material.dart';
import 'package:ran_num_gen/component/number_row.dart';
import 'package:ran_num_gen/constant/colors.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;
  const SettingsScreen({super.key, required this.maxNumber});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Body(
                  maxNumber: maxNumber,
                ),
                _Footer(
                  maxNumber: maxNumber,
                  onSlideChanged: onSliderChanged,
                  onButtonPressed: onButtonPressed,
                )
              ],
            ),
          ),
        ));
  }

  void onSliderChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({super.key, required this.maxNumber});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(number: maxNumber.toInt()),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double> onSlideChanged;
  final VoidCallback onButtonPressed;

  const _Footer({
    super.key,
    required this.maxNumber,
    required this.onSlideChanged,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSlideChanged,
        ),
        ElevatedButton(
          onPressed: onButtonPressed,
          child: Text('저장!'),
          style: ElevatedButton.styleFrom(
            backgroundColor: RED_COLOR,
          ),
        )
      ],
    );
  }
}
