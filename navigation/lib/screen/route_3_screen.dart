import 'package:flutter/material.dart';

import '../layout/main_layout.dart';

class RouteThreeScreen extends StatelessWidget {
  const RouteThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments;
    return MainLayout(
      title: 'Route Three',
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        Text(argument.toString()),
      ],
    );
  }
}
