import 'package:flutter/material.dart';

class TunerPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Standard Tuning', style: TextStyle(fontWeight: FontWeight.bold),), 
                    Icon(Icons.arrow_drop_down_sharp)
                  ]
                ),
                Text('E2 A2 D3 G3 B3 E4', style: TextStyle(fontSize: 15),)
              ],
            ),
            Spacer(),
            Icon(Icons.add)
          ],
        ),

      ),
      body: Center(
         child: Text('TunerPage'),
      ),
    );
  }
}