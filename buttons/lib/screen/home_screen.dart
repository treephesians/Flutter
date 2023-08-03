import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Button',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              // onPressed 에 null 을 넣으면 비활성화 상태를 만들 수 있다.
              onPressed: () {},
              style: ButtonStyle(
                // Material State
                //
                // hovered - 호버링 상태 (마우스 커서를 올려놓은 상태)
                // focused - 포커스 됐을 때 (텍스트 필드)
                // pressed - 눌렸을 때 (o)
                // dragged - 드래그 됐을 때
                // selected - 선택 되었을 때 (체크박스, 라디오 버튼)
                // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을 때
                // disabled - 비활성화 됐을 때 (o)
                // error - 에러상태
                backgroundColor: MaterialStateProperty.all(
                  Colors.black,
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return null;
                  },
                ),
                padding: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return EdgeInsets.all(100.0);
                    }
                  },
                ),
              ),
              child: Text(
                'Button Style',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // 메인 칼라
                backgroundColor: Colors.red,
                // 글씨 및 애니메이션 색깔
                foregroundColor: Colors.black,
                // 그림자 색깔
                shadowColor: Colors.green,
                // 3D 입체감의 높이
                elevation: 10.0,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
                padding: EdgeInsets.all(32.0),
                side: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
              child: Text(
                'Elevated Button',
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                backgroundColor: Colors.yellow,
                elevation: 10.0,
              ),
              child: Text(
                'Outlined Button',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.brown,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {},
              child: Text(
                'Text Button',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
