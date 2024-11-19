import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool isDeparture;

  const StationListPage({Key? key, required this.isDeparture}) : super(key: key);

  static const stations = [
    "수서", "동탄", "평택지제", "천안아산", "오송",
    "대전", "김천구미", "동대구", "경주", "울산", "부산"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isDeparture ? '출발역' : '도착역'),
      ),
      body: ListView.separated(
        itemCount: stations.length,
        separatorBuilder: (_, __) => Divider(color: Colors.grey[300]),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              stations[index],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.pop(context, stations[index]),
          );
        },
      ),
    );
  }
}
