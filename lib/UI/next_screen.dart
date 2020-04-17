import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Latest Screen Title'),),
      body: Container(
        child: Center(child: Text('Latest Screen'),),
      ),
    );
  }
}