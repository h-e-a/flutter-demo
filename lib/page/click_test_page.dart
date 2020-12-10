import 'package:flutter/material.dart';

class ClickTestPage extends StatefulWidget {
  @override
  _ClickTestPageState createState() => _ClickTestPageState();
}

class _ClickTestPageState extends State<ClickTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              print('father');
            },
            child: Container(
              width: 200,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.amber),
              child: InkWell(
                child: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text('small'),
                ),
                onTap: () {
                  print('son');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
