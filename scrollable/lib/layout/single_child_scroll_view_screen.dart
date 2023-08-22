import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class SingleChildeScrollViewScreen extends StatelessWidget {
  const SingleChildeScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      body: SingleChildScrollView(
        child: Column(
          children: rainbowColors
              .map(
                (e) => renderContainer(
                  color: e,
                ),
              )
              .toList(),
        ),
      ),
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

  Widget renderContainer({
    required Color color,
  }) {
    return Container(
      height: 300,
      color: color,
    );
  }
}
