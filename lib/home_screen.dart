import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _waterIntakeController = TextEditingController(
    text: '1',
  );
  List<WaterConsume> waterConsumeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Water Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildWaterConsumeBTN(),
            SizedBox(height: 20),
            SizedBox(
              width: 90,
              child: TextField(
                controller: _waterIntakeController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Glass Count',
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.amber, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('History'),
                Text('Total: ${_getTotalWaterConsume()}'),
              ],
            ),
            Divider(height: 20),
            buildWaterListView(),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildWaterConsumeBTN() {
    return GestureDetector(
      onTap: _addWaterConsume,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),

          border: Border.all(color: Colors.amber, width: 8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(Icons.water_drop_outlined, size: 32),
              Text(
                'Add Water Glass',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWaterListView() {
    return Expanded(
      child: ListView.builder(
        primary: false,
        reverse: true,
        itemCount: waterConsumeList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildSingleListItem(waterConsumeList[index], index + 1);
        },
      ),
    );
  }

  Widget _buildSingleListItem(WaterConsume waterConsume, int selectedIndex) {
    return ListTile(
      title: Text(DateFormat.yMEd().add_jms().format(waterConsume.time)),
      leading: CircleAvatar(
        backgroundColor: Colors.amber,
        child: Text('$selectedIndex'),
      ),
      trailing: Text(
        'Water Glass: ${waterConsume.glassCount}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.green,
        ),
      ),
    );
  }

  void _addWaterConsume() {
    int glassCount = int.tryParse(_waterIntakeController.text) ?? 1;
    WaterConsume waterConsume = WaterConsume(
      time: DateTime.now(),
      glassCount: glassCount,
    );
    waterConsumeList.add(waterConsume);
    setState(() {});
  }

  int _getTotalWaterConsume() {
    int totalCount = 0;
    for (WaterConsume consume in waterConsumeList) {
      totalCount += consume.glassCount;
    }
    return totalCount;
  }
}

class WaterConsume {
  final DateTime time;
  final int glassCount;

  WaterConsume({required this.time, required this.glassCount});
}

//113
