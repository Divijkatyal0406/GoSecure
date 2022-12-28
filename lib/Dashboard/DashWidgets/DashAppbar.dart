import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gosecure/Dashboard/Settings/SettingsScreen.dart';
import 'package:gosecure/constants.dart';

class DashAppbar extends StatefulWidget {
  final Function getRandomInt;
  final int quoteIndex;
  DashAppbar({Key key, this.getRandomInt, this.quoteIndex}) : super(key: key);

  @override
  State<DashAppbar> createState() => _DashAppbarState();
}

class _DashAppbarState extends State<DashAppbar> {
  // Future _delayedFuture = Future.delayed(


  @override
  void initState() {
    // TODO: implement initState
    const t = Duration(seconds:30);
    Timer.periodic(t, (Timer t) => widget.getRandomInt(true));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        sweetSayings[widget.quoteIndex][0],
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.045,
          color: Colors.grey[600],
        ),
      ),
      subtitle: GestureDetector(
        onTap: (){
          widget.getRandomInt(true);
        },
        child: Text(
          sweetSayings[widget.quoteIndex][1],
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.055),
        ),
      ),
      trailing: Card(
        elevation: 4,
        shape: CircleBorder(),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              "assets/settings.png",
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
