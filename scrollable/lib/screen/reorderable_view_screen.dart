import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  final List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return renderContainer(
            color: rainbowColors[numbers[index] % rainbowColors.length],
            //index: index,
            index: numbers[index],
          );
        },
        //itemCount: 100,
        itemCount: numbers.length,
        onReorder: ((int oldIndex, int newIndex) {
          setState(() {
            // [red, orange, yellow]
            // [0, 1, 2]
            //
            // red를 yello 다음으로 옮기고싶다.
            // red : 0 oldIndex -> 3 newIndex
            // [orange, yellow, red]
            // 옮기고 나면 2번이 맞는데, reOrder가 실행되는 기준은 옮기기 전 즉, 3이 맞다.
            //
            // [red, orange, yellow]
            // yellow를 red 전으로 옮기고 싶다.
            // yellow : 2 oldIndex -> 0 newIndex
            // [yellow, red, orange]
            //
            // 패턴은 2개다 oldIndex 와 newIndex 중 무엇이 크고 작냐에 따라서 달라짐!
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        }),
      ),
    );
  }

  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
          )
          .toList(),
      onReorder: ((int oldIndex, int newIndex) {
        setState(() {
          // [red, orange, yellow]
          // [0, 1, 2]
          //
          // red를 yello 다음으로 옮기고싶다.
          // red : 0 oldIndex -> 3 newIndex
          // [orange, yellow, red]
          // 옮기고 나면 2번이 맞는데, reOrder가 실행되는 기준은 옮기기 전 즉, 3이 맞다.
          //
          // [red, orange, yellow]
          // yellow를 red 전으로 옮기고 싶다.
          // yellow : 2 oldIndex -> 0 newIndex
          // [yellow, red, orange]
          //
          // 패턴은 2개다 oldIndex 와 newIndex 중 무엇이 크고 작냐에 따라서 달라짐!
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      }),
    );
  }

  Widget renderContainer(
      {required Color color, required int index, double? height}) {
    if (index != null) {
      print(index);
    }
    return Container(
      key: Key(index.toString()),
      height: height ?? 300, // null 이면 300 넣어라
      color: color,
      child: Text(
        index.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 30.0,
        ),
      ),
    );
  }
}
