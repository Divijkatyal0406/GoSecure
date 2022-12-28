import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:swipe_button/swipe_button.dart';
import 'package:flutter/services.dart';

class SwipeButtonDemo extends StatelessWidget {
  final String pageRoute;
  final String buttonTitle;

  const SwipeButtonDemo({Key key, this.pageRoute, this.buttonTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SwipeButton(
                  thumb: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                          widthFactor: 0.90,
                          child: Icon(
                            Icons.chevron_right,
                            size: 50.0,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  content: Center(
                    child: Text(
                      'Report to NCW cell',
                      style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width * 0.043,),
                    ),
                  ),
                  onChanged: (result) {
                    if (result == SwipePosition.SwipeRight) {
                     _callNumber("7827170170");
                    } else {}
                  },
                ),
              ),
            ),
          ],
        );
  }
  _callNumber(number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
