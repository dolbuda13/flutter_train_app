import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    Key? key,
    required this.departureStation,
    required this.arrivalStation,
  }) : super(key: key);

  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<List<bool>> selectedSeats = List.generate(
    20,
    (_) => List.generate(4, (_) => false), // 20 rows, 4 columns of seats
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            // 역 이름 섹션
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStationText(widget.departureStation),
                const Icon(Icons.arrow_circle_right_outlined, size: 30),
                _buildStationText(widget.arrivalStation),
              ],
            ),
            const SizedBox(height: 20),

            // 좌석 상태 설명
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSeatStatusBox(true),
                const SizedBox(width: 4),
                const Text("선택됨"),
                const SizedBox(width: 20),
                _buildSeatStatusBox(false),
                const SizedBox(width: 4),
                const Text("선택안됨"),
              ],
            ),
            const SizedBox(height: 20),

            //좌석 레이블(A, B, C, D)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('A', style: TextStyle(fontSize: 18)),
                Text('B', style: TextStyle(fontSize: 18)),
                Text('C', style: TextStyle(fontSize: 18)),
                Text('D', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 10),

            //좌석 스크롤
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(20, (rowIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 행 번호
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center, // 행 번호를 가로세로 정중앙으로 정렬
                            child: Text(
                              '${rowIndex + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // 좌석
                          for (int colIndex = 0; colIndex < 4; colIndex++)
                            _buildSeatWidget(rowIndex, colIndex),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),

            // 예매하기 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // 예매하기
                },
                child: const Text(
                  '예매 하기',
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

  // 역 이름 위젯
  Widget _buildStationText(String station) {
    return Text(
      station,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  // 좌석 상태 박스
  Widget _buildSeatStatusBox(bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  // 좌석 위젯
  Widget _buildSeatWidget(int rowIndex, int colIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSeats[rowIndex][colIndex] = !selectedSeats[rowIndex][colIndex];
        });
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: selectedSeats[rowIndex][colIndex]
              ? Colors.purple
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
