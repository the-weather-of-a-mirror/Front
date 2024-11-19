import 'package:flutter/material.dart';
import 'package:whether/WarningScreen/DisasterWarning.dart';
import 'package:whether/WarningScreen/SaveTool.dart';
import 'package:whether/WarningScreen/ShelterInfo.dart';

class WarningScreen extends StatelessWidget {
  final List<String> warningText = ["대피소 정보", "구호 물품", "재난 대피시\n주의사항"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // 배경을 밝은 회색으로 설정
      body: Column(
        children: [
          const SizedBox(height: 90), // 화면을 아래로 내리기 위한 여백 추가
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 600 ? 3 : 2, // 반응형 컬럼 수
                    mainAxisSpacing: 16, // 세로 간격
                    crossAxisSpacing: 16, // 가로 간격
                    childAspectRatio: 1, // 아이템의 가로 세로 비율
                  ),
                  padding: const EdgeInsets.all(16), // 외부 여백
                  itemCount: warningText.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      // 페이지 전환 로직
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ShelterInfo()),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SaveTool()),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Disasterwarning()),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black, // 버튼 색상 검정
                        borderRadius: BorderRadius.circular(12), // 모서리를 둥글게
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26, // 그림자 색
                            blurRadius: 6, // 그림자 흐림 정도
                            offset: Offset(0, 4), // 그림자 위치
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          warningText[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white, // 텍스트 색상 흰색
                            fontSize: 16, // 텍스트 크기
                            fontWeight: FontWeight.bold, // 텍스트 굵기
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
