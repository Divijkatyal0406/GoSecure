import 'package:flutter/material.dart';
import 'package:gosecure/Dashboard/DashWidgets/Cab/Ola.dart';
import 'package:gosecure/Dashboard/DashWidgets/Cab/Rapido.dart';

import 'Cab/Uber.dart';

class BookCab extends StatelessWidget {
  const BookCab({Key key}) : super(key: key);

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
            RadpidoCard()
          ]),
    );
  }
}
