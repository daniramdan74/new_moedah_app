import 'package:flutter/material.dart';
import 'package:new_moedah_app/widgets/drawer.dart';

class ReportPage extends StatelessWidget {
  static const String routeName = '/report';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Report"),
        ),
        drawer: AppDrawer(),
        body: Center(child: Text("Report")));
  }
}