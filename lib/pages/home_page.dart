import 'package:flutter/material.dart';
import 'station_list_page.dart';
import 'seat_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  void _selectStation(bool isDeparture, String station) {
    setState(() {
      if (isDeparture) {
        departureStation = station;
      } else {
        arrivalStation = station;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('기차 예매'),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStationSelectorBox(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // 박스와 동일한 가로 길이를 맞추기 위해 사용
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: (departureStation != null && arrivalStation != null)
                    ? () {
                        // 좌석 선택 페이지로 이동, departureStation과 arrivalStation을 전달
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatPage(
                              departureStation: departureStation!,
                              arrivalStation: arrivalStation!,
                            ),
                          ),
                        );
                      }
                    : null,
                child: const Text(
                  '좌석 선택',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationSelectorBox() {
    return Container(
      height: 200,
      width: double.infinity, // 부모 위젯의 가로 길이에 맞춤
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStationColumn(true),
          Container(
            width: 2,
            height: 50,
            color: Colors.grey[400],
          ),
          _buildStationColumn(false),
        ],
      ),
    );
  }

  Widget _buildStationColumn(bool isDeparture) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          final station = await Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => StationListPage(isDeparture: isDeparture),
            ),
          );
          if (station != null) {
            _selectStation(isDeparture, station);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isDeparture ? '출발역' : '도착역', // true이면 출발역, false이면 도착역
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isDeparture ? departureStation ?? '선택' : arrivalStation ?? '선택',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
