import 'package:flutter/material.dart';
import 'package:navigation/screen/route_3_screen.dart';

import '../layout/main_layout.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments: ${arguments}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 999,
            );
          },
          child: Text('Push Name'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              '/three',
            );
          },
          child: Text('Push Replacement'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) => route.settings.name == '/', //바로 home으로 감.
            );
          },
          child: Text('Push and Remove Until'),
        ),
      ],
    );
  }
}
