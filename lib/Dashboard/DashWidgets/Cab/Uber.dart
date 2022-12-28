import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';


class UberCard extends StatelessWidget {
  const UberCard({Key key}) : super(key: key);
  _openUber () async{
      List<Application> apps = await DeviceApps.getInstalledApplications();
      print(apps);
      // DeviceApps.openApp("com.ubercab");

      // String dt = "https://play.google.com/store/apps/details?id=com.ubercab&gl=US";
      // bool isInstalled = await DeviceApps.isAppInstalled('com.ubercab');
      // if (isInstalled != false)
      // {
      //   AndroidIntent intent = AndroidIntent(
      //       action: 'action_view',
      //       data: dt
      //   );
      //   await intent.launch();
      // }
      // else
      // {
      //   String url = dt;
      //   if (await canLaunch(url))
      //     await launch(url);
      //   else
      //     throw 'Could not launch $url';
      // }
      try {
        ///checks if the app is installed on your mobile device
        bool isInstalled = await DeviceApps.isAppInstalled('com.ubercab');
        if (isInstalled) {
          print("hello");
          DeviceApps.openApp("com.ubercab");
        } else {
          ///if the app is not installed it lunches google play store so you can install it from there
          launch("market://details?id=" +"com.ubercab");
        }
      } catch (e) {
        print(e);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: (){
                _openUber();
              },
              child: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Image.asset(
                        "assets/uber.png",
                        height: 32,
                      ))),
            ),
          ),
          Text("Uber")
        ],
      ),
    );
  }
}
