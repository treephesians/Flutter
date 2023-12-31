import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class SingleChildeScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  SingleChildeScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      body: renderPerformance(),
    );
  }

  // 1
  // 기본 렌더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(
                color: e,
              ),
            )
            .toList(),
      ),
    );
  }

  // 2
  // 화면을 넘어가지 않아도 스크롤 되게 하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      //physics: NeverScrollableScrollPhysics(),
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 3
  // 화면이 넘어가도 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      //physics: NeverScrollableScrollPhysics(),
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 4
  // 여러가지 physics 정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      //physics: NeverScrollableScrollPhysics(), : 스크롤 안됨.
      //physics: AlwaysScrollableScrollPhysics(), : 스크롤 됨.
      //physics: BouncingScrollPhysics(), : ios 스타일
      //physics: ClampingScrollPhysics(), : Android 스타일
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(
                color: e,
              ),
            )
            .toList(),
      ),
    );
  }

  // 5
  // SingleChildScrollView 퍼포먼스
  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              // 한번에 다 렌더링을 함!
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if (index != null) {
      print(index);
    }
    return Container(
      height: 300,
      color: color,
    );
  }
}
