import 'package:flutter/material.dart';
import 'package:scrollable/layout/main_layout.dart';
import 'package:scrollable/layout/single_child_scroll_view_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SingleChildeScrollViewScreen(),
                  ),
                );
              },
              child: Text('SingleChildScrollViewScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
