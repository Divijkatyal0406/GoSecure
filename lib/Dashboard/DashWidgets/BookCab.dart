import 'package:flutter/material.dart';
import 'package:gosecure/Dashboard/DashWidgets/Cab/Ola.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Cab/Uber.dart';

class BookCab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: [
            UberCard(),
            OlaCard(),
          ]),
    );
  }
}
