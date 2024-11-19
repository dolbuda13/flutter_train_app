import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool isDeparture;

  const StationListPage({Key? key, required this.isDeparture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> stations = [//역 목록
      '수서',
      '동탄',
      '평택지제',
      '천안아산',
      '오송',
      '대전',
      '김천구미',
      '동대구',
      '경주',
      '울산',
      '부산',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isDeparture ? '출발역 선택' : '도착역 선택'), //true 이면 출발역 선택, false이면 도착역 선책하도록 반환
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: ListTile(
              title: Text(
                stations[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context, stations[index]); // 선택된 역 반환
              },
            ),
          );
        },
      ),
    );
  }
}
