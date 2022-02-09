import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [
          Icon(Icons.error, color: Colors.red),
          Text('No data', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
