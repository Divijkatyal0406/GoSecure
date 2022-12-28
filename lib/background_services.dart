import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:workmanager/workmanager.dart';

void onStart() async {
  bool check=true;
  if(check){
    SharedPreferences.setMockInitialValues({});
    check=false;
  }
  print("bye");
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  print("bye1");
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  print("bye2");

  service.onDataReceived.listen((event) async {
    if (event["action"] == "setAsForeground") {
      service.setForegroundMode(true);

      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(true);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });
  String loc;
  // String longg;

  print("he;");
  await BackgroundLocation.setAndroidNotification(
    title: "Location tracking is running in the background!",
    message: "You can turn it off from settings menu inside the app",
    icon: '@mipmap/ic_logo',
  );

  // This is where the location service gets started.
  await BackgroundLocation.startLocationService(
    distanceFilter: 20,
  );

  // BackgroundLocation.getLocationUpdates((location) {
  //   latt=location.latitude.toString();
  //   longg=location.longitude.toString();
  //   // _location.latitude = location.latitude.toString() as double;
  //   // _location.longitude = location.longitude.toString() as double;
  //   // prefs.setStringList("location",
  //   //     [location.latitude.toString(), location.longitude.toString()]);
  // });
  // _location.latitude=1.0 as double;

  GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
  Position userLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  print(userLocation);
  String screenShake = "Be strong, We are with you!";
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
          screenShake = "SOS alert Sent! Help is on the way.";
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
              screenShake = "SOS alert Sent! Help is on the way.";
              debugPrint(
                'No Contacts Found!',
              );
              return;
            } else {
              // SharedPreferences.setMockInitialValues({});
              for (int i = 0; i < numbers.length; i++) {
                //Here I used telephony to send sms messages to the saved contacts.
                Telephony.backgroundInstance.sendSms(
                    to: numbers[i], message: "Help Me! Track me here.\n$link");
              }
              prefs.setBool("alerted", true);
              screenShake = "SOS alert Sent! Help is on the way.";
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
          // screenShake = "SOS alert Sent! Help is on the way.";
          // double lat =1.0;
          // double long = 2.0;
          // print("$lat ... $long");
          // print("Test 9");
          // link = "http://maps.google.com/?q=$lat,$long";
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // List<String> numbers = prefs.getStringList("numbers") ?? [];
          // print(numbers);
          // String error;
          // try {
          //   if (numbers.isEmpty) {
          //     screenShake = "No contacts found, Please call 100 ASAP.";
          //     debugPrint(
          //       'No Contacts Found!',
          //     );
          //     return;
          //   } else {
          //     for (int i = 0; i < numbers.length; i++) {
          //       //Here I used telephony to send sms messages to the saved contacts.
          //       Telephony.backgroundInstance.sendSms(
          //           to: numbers[i], message: "Help Me! Track me here.\n$link");
          //     }
          //     prefs.setBool("alerted", true);
          //     screenShake = "SOS alert Sent! Help is on the way.";
          //   }
          // } on PlatformException catch (e) {
          //   if (e.code == 'PERMISSION_DENIED') {
          //     error = 'Please grant permission';
          //     print('Error due to Denied: $error');
          //   }
          //   if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          //     error = 'Permission denied- please enable it from app settings';
          //     print("Error due to not Asking: $error");
          //   }
          // }
          print(e);
        }
      });
  print("Test 12");
  // on initial call to onStart() this will call which brings the background
  // service to life
  service.setForegroundMode(true);
  // Timer is placed so the background isolate can work every
  // second unlike other worker managers
  Timer.periodic(Duration(seconds: 1), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();

    service.setNotificationInfo(
      title: "Safe Shake activated!",
      content: screenShake,
    );

    service.sendData(
      {"current_date": DateTime.now().toIso8601String()},
    );
  });
}

//GET HOME SAFE _ WORK MANAGER SET TO 15 minutes frequency


// This fumction is attached to get home safe functionality 
// which will send the user location data to his/her selected 
// contact after every 15 minutes.

// Its simply a workManager which is executing a given task perioadically 
// afeter every 15 minutes


void callbackDispatcher() {
  print("hello");
  Workmanager().executeTask((task, inputData) async {
    String contact = inputData['contact'];
    final prefs = await SharedPreferences.getInstance();
    print(contact);
    List<String> location = prefs.getStringList("location");
    String link = "http://maps.google.com/?q=${location[0]},${location[1]}";
    print(location);
    print(link);
    Telephony.backgroundInstance
        .sendSms(to: contact, message: "I am on my way! Track me here.\n$link");
    return true;
  });
}

// I hope this project have helped you
// And I am just happy that I have helped you in any way :)
// May your all wishes come true - Happy Fluttering <3