import 'package:BitmojiStickers/pages/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Dashboard(),
    );
  }
}
