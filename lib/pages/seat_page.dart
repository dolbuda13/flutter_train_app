import 'package:flutter/cupertino.dart';
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
    (_) => List.generate(4, (_) => false),
  );

  void _showConfirmationDialog() {
    // 선택된 좌석 번호를 가져오기
    List<String> selectedSeatNumbers = [];
    for (int row = 0; row < selectedSeats.length; row++) {
      for (int col = 0; col < selectedSeats[row].length; col++) {
        if (selectedSeats[row][col]) {
          // 좌석 번호는 A, B, C, D를 사용
          String seatLabel = String.fromCharCode(65 + col); // A, B, C, D
          selectedSeatNumbers.add('${row + 1}$seatLabel');
        }
      }
    }

    // 다이얼로그 출력
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('예매하시겠습니까?'),
        content: Text(
          selectedSeatNumbers.isNotEmpty
              ? '좌석 번호: ${selectedSeatNumbers.join(', ')}'
              : '선택된 좌석이 없습니다.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () {
              Navigator.pop(context); // Dialog 닫기
            },
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context); // Dialog 닫기
              Navigator.pop(context); // HomePage로 돌아가기
            },
          ),
        ],
      ),
    );
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStationText(widget.departureStation),
                const Icon(Icons.arrow_circle_right_outlined, size: 30),
                _buildStationText(widget.arrivalStation),
              ],
            ),
            const SizedBox(height: 20),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(20, (rowIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              '${rowIndex + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          for (int colIndex = 0; colIndex < 4; colIndex++)
                            _buildSeatWidget(rowIndex, colIndex),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
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
                onPressed: _showConfirmationDialog,
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

  Widget _buildSeatWidget(int rowIndex, int colIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSeats[rowIndex][colIndex] =
              !selectedSeats[rowIndex][colIndex];
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
