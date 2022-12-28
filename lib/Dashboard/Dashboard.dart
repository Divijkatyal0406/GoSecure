import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:blurry/blurry.dart';
// import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
// import 'package:alan_voice/alan_voice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as appPermissions;
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_maintained/sms.dart' as smsSender;
import 'package:gosecure/Dashboard/ContactScreens/phonebook_view.dart';
import 'package:gosecure/Dashboard/Home.dart';
import 'package:gosecure/Dashboard/ContactScreens/MyContacts.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';

class Dashboard extends StatefulWidget {
  final int pageIndex;
  const Dashboard({Key key, this.pageIndex = 0}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState(currentPage: pageIndex);
}

class _DashboardState extends State<Dashboard> {
  // _DashboardState({this.currentPage = 0});

  // _DashboardState(){
  //   AlanVoice.addButton(
  //       "6e9af97f9e4cb20c7996be56c8ddc53a2e956eca572e1d8b807a3e2338fdd0dc/stage",
  //       buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
  //
  //   /// Handle commands from Alan Studio
  //   AlanVoice.onCommand.add((command) {
  //     debugPrint("got new command ${command.toString()}");
  //   });
  // }
  _DashboardState({this.currentPage=0});

  List<Widget> screens = [Home(), MyContactsScreen()];
  bool alerted = false;
  int currentPage = 0;
  var _battery = Battery();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  bool pinChanged = false;
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }


  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(
        shakeThresholdGravity: 7,
        onPhoneShake: () async {
          print("Test 1");
          if (await Vibration.hasVibrator()) {
            print("Test 2");
            if (await Vibration.hasCustomVibrationsSupport()) {
              print("Test 3");
              Vibration.vibrate(duration: 1000);
            } else {
              print("Test 4");
              Vibration.vibrate();
              await Future.delayed(Duration(milliseconds: 500));
              Vibration.vibrate();
            }
            print("Test 5");
          }
          print("Test 6");
          String link = '';
          print("Test 7");
          try {
            double lat =1.0;
            double long = 2.0;
            print("$lat ... $long");
            print("Test 9");
            link = "http://maps.google.com/?q=$lat,$long";
            SharedPreferences prefs = await SharedPreferences.getInstance();
            List<String> numbers = prefs.getStringList("numbers") ?? [];
            print(numbers);
            String error;
            try {
              if (numbers.isEmpty) {
                debugPrint(
                  'No Contacts Found!',
                );
                SchedulerBinding.instance.addPostFrameCallback((_) => showLocAlert(context));
                return;
              } else {
                print("heheehehehehhe");
                for (int i = 0; i < numbers.length; i++) {
                  //Here I used telephony to send sms messages to the saved contacts.
                  // Telephony.backgroundInstance.sendSms(
                  //     to: numbers[i], message: "Help Me! Track me here.\n$link");
                    if (alerted) {
                      int pin = (prefs.getInt('pin') ?? -1111);
                      print('User $pin .');
                      if (pin == -1111) {
                        sendAlertSMS(false);
                      } else {
                        showPinModelBottomSheet(pin);
                      }
                    } else {
                      sendAlertSMS(true);
                    }
                }
                prefs.setBool("alerted", true);
              }
            } on PlatformException catch (e) {
              if (e.code == 'PERMISSION_DENIED') {
                error = 'Please grant permission';
                print('Error due to Denied: $error');
              }
              if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
                error = 'Permission denied- please enable it from app settings';
                print("Error due to not Asking: $error");
              }
            }
            print("Test 10");
            print(link);
          } catch (e) {
            print("Test 11");
            print(e);
          }
        });
    // getBattery();
    checkAlertSharedPreferences();
    checkPermission();
  }

  // getBattery() async{
  //   print(await _battery.batteryLevel);
  // }

  SharedPreferences prefs;
  checkAlertSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (mounted)
      setState(() {
        alerted = prefs.getBool("alerted") ?? false;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      floatingActionButton: currentPage == 1
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneBook()));
              },
              child: Image.asset(
                "assets/add-contact.png",
                height: 60,
              ),
            )
          : FloatingActionButton(
              backgroundColor: Colors.orange.shade50,
              onPressed: () async {
                if (alerted) {
                  int pin = (prefs.getInt('pin') ?? -1111);
                  print('User $pin .');
                  if (pin == -1111) {
                    sendAlertSMS(false);
                  } else {
                    showPinModelBottomSheet(pin);
                  }
                } else {
                  sendAlertSMS(true);
                }
              },
              child: alerted
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/alarm.png",
                          height: 24,
                        ),
                        Text("STOP",style: TextStyle(color: Colors.black),)
                      ],
                    )
                  : Image.asset(
                      "assets/icons/sos_icon1.png",
                      height: 36,
                    ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    if (currentPage != 0)
                      setState(() {
                        currentPage = 0;
                      });
                  },
                  child: Image.asset(
                    "assets/home.png",
                    height: 28,
                  )),
              InkWell(
                  onTap: () {
                    if (currentPage != 1)
                      setState(() {
                        currentPage = 1;
                      });
                  },
                  child: Image.asset("assets/phone_red.png", height: 28)),
            ],
          ),
        ),
      ),
      body: SafeArea(child: screens[currentPage]),
    );
  }

  checkPermission() async {
    appPermissions.PermissionStatus conPer =
        await appPermissions.Permission.contacts.status;
    appPermissions.PermissionStatus locPer =
        await appPermissions.Permission.location.status;
    appPermissions.PermissionStatus phonePer =
        await appPermissions.Permission.phone.status;
    appPermissions.PermissionStatus smsPer =
        await appPermissions.Permission.sms.status;
    if (conPer != appPermissions.PermissionStatus.granted) {
      await appPermissions.Permission.contacts.request();
    }
    if (locPer != appPermissions.PermissionStatus.granted) {
      await appPermissions.Permission.location.request();
    }
    if (phonePer != appPermissions.PermissionStatus.granted) {
      await appPermissions.Permission.phone.request();
    }
    if (smsPer != appPermissions.PermissionStatus.granted) {
      await appPermissions.Permission.sms.request();
    }
  }

  void sendSMS(String number, String msgText) {
    print(number);
    print(msgText);
    smsSender.SmsMessage msg = new smsSender.SmsMessage(number, msgText);
    final smsSender.SmsSender sender = new smsSender.SmsSender();
    msg.onStateChanged.listen((state) {
      if (state == smsSender.SmsMessageState.Sending) {
        return Fluttertoast.showToast(
          msg: 'Sending Alert...',
          backgroundColor: Colors.blue,
        );
      } else if (state == smsSender.SmsMessageState.Sent) {
        return Fluttertoast.showToast(
          msg: 'Alert Sent Successfully!',
          backgroundColor: Colors.green,
        );
      } else if (state == smsSender.SmsMessageState.Fail) {
        return Fluttertoast.showToast(
          msg: 'Failure! Check your credits & Network Signals!',
          backgroundColor: Colors.red,
        );
      } else {
        return Fluttertoast.showToast(
          msg: 'Failed to send SMS. Please Wait!',
          backgroundColor: Colors.red,
        );
      }
    });
    sender.sendSms(msg);
  }

  sendAlertSMS(bool isAlert) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool("alerted", isAlert);
      alerted = isAlert;
    });
    checkPermission();

    prefs.setBool("alerted", isAlert);
    List<String> numbers = prefs.getStringList("numbers") ?? [];
    LocationData myLocation;
    String error;
    Location location = new Location();
    String link = '';
    try {
      myLocation = await location.getLocation();
      var currentLocation = myLocation;

      if (numbers.isEmpty) {
        setState(() {
          prefs.setBool("alerted", false);
          alerted = false;
        });
        return Fluttertoast.showToast(
          msg: 'No Contacts Found!',
          backgroundColor: Colors.red,
        );
      } else {
        //var coordinates =
        //    Coordinates(currentLocation.latitude, currentLocation.longitude);
        //var addresses =
        //    await Geocoder.local.findAddressesFromCoordinates(coordinates);
        // var first = addresses.first;
        String li =
            "http://maps.google.com/?q=${currentLocation.latitude},${currentLocation.longitude}";
        if (isAlert) {
          link = "Help Me! SOS \n$li";
        } else {
          Fluttertoast.showToast(
              msg: "Contacts are being notified about false SOS.");
          link = "I am safe, track me here\n$li";
        }

        for (int i = 0; i < numbers.length; i++) {
          sendSMS(numbers[i].split("***")[1], link);
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Please grant permission';
        print('Error due to Denied: $error');
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied- please enable it from app settings';
        print("Error due to not Asking: $error");
      }
      myLocation = null;

      prefs.setBool("alerted", false);

      setState(() {
        alerted = false;
      });
    }
  }

  showPinModelBottomSheet(int userPin) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    Text(
                      "Please enter you PIN!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
                Image.asset("assets/pin.png"),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  child: PinPut(
                    onSaved: (value) {
                      print(value);
                    },
                    fieldsCount: 4,
                    onSubmit: (String pin) =>
                        _showSnackBar(pin, context, userPin),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.deepPurpleAccent.withOpacity(.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
  void showLocAlert(BuildContext context){
    Blurry.error(
        title:'Missing Contact',
        // layoutType: LayoutType.center,
        description:
        'No contacts found. Call 100 ASAP or tap our assistant and say POLICE',
        popupHeight: MediaQuery.of(context).size.height/3.1,
        confirmButtonText:  'OK',
        onConfirmButtonPressed: () {
          Navigator.pop(context);
        })
        .show(context);
  }
  void _showSnackBar(String pin, BuildContext context, int userPin) {
    if (userPin == int.parse(pin)) {
      Fluttertoast.showToast(
        msg: 'We are glad that you are safe',
      );
      sendAlertSMS(false);
      _pinPutController.clear();
      _pinPutFocusNode.unfocus();
    } else {
      Fluttertoast.showToast(
        msg: 'Wrong Pin! Please try again',
      );
    }
  }
}
