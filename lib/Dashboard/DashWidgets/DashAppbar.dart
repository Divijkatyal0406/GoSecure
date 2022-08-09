import 'package:flutter/material.dart';
import 'package:gosecure/constants.dart';

class DashAppbar extends StatelessWidget {
  final Function getRandomInt;
  final int quoteIndex;
  DashAppbar({required this.getRandomInt, required this.quoteIndex});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        sweetSayings[quoteIndex][0],
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      subtitle: GestureDetector(
        onTap: (){
          getRandomInt(true);
        },
        child: Text(
          sweetSayings[quoteIndex][1],
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.06),
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
