import 'package:android_intent_plus/android_intent.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gosecure/HiddenCamera/detection.dart';


import '../../../Fake call/fake.dart';
import '../../../Fake call/fake_call_support.dart';

class OlaCard extends StatelessWidget {
  const OlaCard({Key key}) : super(key: key);

  _openOla () async{
    // List<Application> apps = await DeviceApps.getInstalledApplications();
    // DeviceApps.openApp("com.ubercab");

    String dt = "https://play.google.com/store/apps/details?id=com.olacabs.customer&gl=US";
    bool isInstalled = await DeviceApps.isAppInstalled('com.olacabs.customer');
    if (isInstalled != false)
    {
      AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          data: dt
      );
      await intent.launch();
    }
    else
    {
      String url = dt;
      if (await canLaunch(url))
        await launch(url);
      else
        throw 'Could not launch $url';
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
                _openOla();
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detection()));
              },
              child: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Image.asset(
                        "assets/ola.png",
                        height: 32,
                      ))),
            ),
          ),
          Text("Ola")
        ],
      ),
    );
  }
}
