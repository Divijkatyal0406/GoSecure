// // import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// import 'dart:math' as math;
// // import 'package:tflite/tflite.dart';
// import 'package:gosecure/HiddenCamera/Bounding_box.dart';
// import 'package:gosecure/HiddenCamera/camera.dart';
//
// class LiveFeed extends StatefulWidget {
//   // final List<CameraDescription> cameras;
//   // LiveFeed(this.cameras);
//   @override
//   _LiveFeedState createState() => _LiveFeedState();
// }
//
// class _LiveFeedState extends State<LiveFeed> {
//   List<dynamic> _recognitions;
//   int _imageHeight = 0;
//   int _imageWidth = 0;
//   initCameras() async {
//
//   }
//   // loadTfModel() async {
//   //   await Tflite.loadModel(
//   //     model: "assets/models/ssd_mobilenet.tflite",
//   //     labels: "assets/models/labels.txt",
//   //   );
//   // }
//   /*
//   The set recognitions function assigns the values of recognitions, imageHeight and width to the variables defined here as callback
//   */
//   setRecognitions(recognitions, imageHeight, imageWidth) {
//     setState(() {
//       _recognitions = recognitions;
//       _imageHeight = imageHeight;
//       _imageWidth = imageWidth;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // loadTfModel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.black, //change your color here
//         ),
//         backgroundColor: Colors.white,
//         title: Text("Real Time Detection",style: TextStyle(color: Colors.black),),
//       ),
//       body: Stack(
//         children: <Widget>[
//           // CameraFeed(widget.cameras, setRecognitions),
//           BoundingBox(
//             _recognitions == null ? [] : _recognitions,
//             math.max(_imageHeight, _imageWidth),
//             math.min(_imageHeight, _imageWidth),
//             screen.height,
//             screen.width,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

class LiveFeed extends StatefulWidget {
  const LiveFeed({Key key}) : super(key: key);

  @override
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _gyroscope = Vector3.zero();
  Vector3 _magnetometer = Vector3.zero();
  Vector3 _userAaccelerometer = Vector3.zero();
  Vector3 _orientation = Vector3.zero();
  Vector3 _absoluteOrientation = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  double _screenOrientation = 0;

  int _groupValue = 0;

  @override
  void initState() {
    super.initState();
    motionSensors.gyroscope.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscope.setValues(event.x, event.y, event.z);
      });
    });
    motionSensors.accelerometer.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometer.setValues(event.x, event.y, event.z);
      });
    });
    motionSensors.userAccelerometer.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAaccelerometer.setValues(event.x, event.y, event.z);
      });
    });
    motionSensors.magnetometer.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometer.setValues(event.x, event.y, event.z);
        var matrix =
            motionSensors.getRotationMatrix(_accelerometer, _magnetometer);
        _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
      });
    });
    motionSensors.isOrientationAvailable().then((available) {
      if (available) {
        motionSensors.orientation.listen((OrientationEvent event) {
          setState(() {
            _orientation.setValues(event.yaw, event.pitch, event.roll);
          });
        });
      }
    });
    motionSensors.absoluteOrientation.listen((AbsoluteOrientationEvent event) {
      setState(() {
        _absoluteOrientation.setValues(event.yaw, event.pitch, event.roll);
      });
    });
    motionSensors.screenOrientation.listen((ScreenOrientationEvent event) {
      setState(() {
        _screenOrientation = event.angle;
      });
    });
  }

  void setUpdateInterval(int groupValue, int interval) {
    motionSensors.accelerometerUpdateInterval = interval;
    motionSensors.userAccelerometerUpdateInterval = interval;
    motionSensors.gyroscopeUpdateInterval = interval;
    motionSensors.magnetometerUpdateInterval = interval;
    motionSensors.orientationUpdateInterval = interval;
    motionSensors.absoluteOrientationUpdateInterval = interval;
    setState(() {
      _groupValue = groupValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              title: Text(
                "Real Time Detection",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SafeArea(
                child: Stack(fit: StackFit.expand, children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/bg-spy.jpg',
                    ),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                  color: Colors.grey[50].withOpacity(0.3),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height/15,
                      ),
                      // Text('Update Interval'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _groupValue,
                            onChanged: (dynamic value) => setUpdateInterval(
                                value, Duration.microsecondsPerSecond ~/ 1),
                          ),
                          Text("1 FPS"),
                          Radio(
                            value: 2,
                            groupValue: _groupValue,
                            onChanged: (dynamic value) => setUpdateInterval(
                                value, Duration.microsecondsPerSecond ~/ 30),
                          ),
                          Text("30 FPS"),
                          Radio(
                            value: 3,
                            groupValue: _groupValue,
                            onChanged: (dynamic value) => setUpdateInterval(
                                value, Duration.microsecondsPerSecond ~/ 60),
                          ),
                          Text("60 FPS"),
                        ],
                      ),
                      Text('Accelerometer'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('${_accelerometer.x.toStringAsFixed(4)}'),
                          Text('${_accelerometer.y.toStringAsFixed(4)}'),
                          Text('${_accelerometer.z.toStringAsFixed(4)}'),
                        ],
                      ),
                      Text('Magnetometer'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('${_magnetometer.x.toStringAsFixed(4)}'),
                          Text('${_magnetometer.y.toStringAsFixed(4)}'),
                          Text('${_magnetometer.z.toStringAsFixed(4)}'),
                        ],
                      ),
                      Text('Gyroscope'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('${_gyroscope.x.toStringAsFixed(4)}'),
                          Text('${_gyroscope.y.toStringAsFixed(4)}'),
                          Text('${_gyroscope.z.toStringAsFixed(4)}'),
                        ],
                      ),
                      Text('User Accelerometer'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('${_userAaccelerometer.x.toStringAsFixed(4)}'),
                          Text('${_userAaccelerometer.y.toStringAsFixed(4)}'),
                          Text('${_userAaccelerometer.z.toStringAsFixed(4)}'),
                        ],
                      ),
                      Text('Orientation'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('${degrees(_orientation.x).toStringAsFixed(4)}'),
                          Text('${degrees(_orientation.y).toStringAsFixed(4)}'),
                          Text('${degrees(_orientation.z).toStringAsFixed(4)}'),
                        ],
                      ),
                      Text('Absolute Orientation'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                              '${degrees(_absoluteOrientation.x).toStringAsFixed(4)}'),
                          Text(
                              '${degrees(_absoluteOrientation.y).toStringAsFixed(4)}'),
                          Text(
                              '${degrees(_absoluteOrientation.z).toStringAsFixed(4)}'),
                        ],
                      ),
                      Text('Orientation (accelerometer + magnetometer)'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                              '${degrees(_absoluteOrientation2.x).toStringAsFixed(4)}'),
                          Text(
                              '${degrees(_absoluteOrientation2.y).toStringAsFixed(4)}'),
                          Text(
                              '${degrees(_absoluteOrientation2.z).toStringAsFixed(4)}'),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'No Potencial Spy Camera Found!!',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.06),
                      ),
                    ],
                  ),
                ),
              ),
            ]))));
  }
}
