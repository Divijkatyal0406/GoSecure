// import 'package:fancy_text_reveal/fancy_text_reveal.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gosecure/Dashboard/Dashboard.dart';
// import 'package:liquid_swipe/liquid_swipe.dart';
// import 'package:get/get.dart';
//
// class Onboarding extends StatelessWidget {
//   final pages = [
//     Container(
//       color: Colors.pink,
//       child:
//           Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Image.asset(
//               'assets/1.png',
//               fit: BoxFit.cover,
//             ),
//             Padding(padding: const EdgeInsets.all(10.0)),
//             Column(
//               children: <Widget>[
//                 new Text(
//                   "Too Fear to walk alone",
//                   style: TextStyle(
//                       fontSize: 26,
//                       fontFamily: "Billy",
//                       fontWeight: FontWeight.w600,color: Colors.lightGreenAccent),
//                 ),
//                 new Text(
//                   "Let's help you!",
//                   style: TextStyle(
//                       fontSize: 26,
//                       fontFamily: "Billy",
//                       fontWeight: FontWeight.w600,color: Colors.lightGreenAccent),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 new Text(
//                   "Empowering Women",
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontFamily: "Billy",
//                       fontWeight: FontWeight.w600,color: Colors.white),
//                 ),
//                 new Text(
//                   "With Safety.",
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontFamily: "Billy",
//                       fontWeight: FontWeight.w600,color: Colors.white),
//                 ),
//               ],
//             ),
//             Positioned(top: 10,right: 2,child: FancyTextReveal(child: GestureDetector(onTap: (){Get.to(Dashboard());} ,child: Text('Skip',style: TextStyle(decoration: TextDecoration.underline,fontSize: 20),)))),
//           ],
//         ),
//       ),
//     // ),
//     Container(
//       color: Colors.deepPurpleAccent,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Image.asset(
//             'assets/1.png',
//             fit: BoxFit.cover,
//           ),
//           Padding(padding: const EdgeInsets.all(20.0)),
//           Column(
//             children: <Widget>[
//               new Text(
//                 "Always Stay Connected",
//                 style: TextStyle(
//                     fontSize: 26,
//                     fontFamily: "Billy",
//                     fontWeight: FontWeight.w600,color: Colors.yellow),
//               ),
//               new Text(
//                 "for a",
//                 style: TextStyle(
//                     fontSize: 26,
//                     fontFamily: "Billy",
//                     fontWeight: FontWeight.w600,color: Colors.yellow),
//               ),
//               new Text(
//                 "safer walk.",
//                 style: TextStyle(
//                     fontSize: 26,
//                     fontFamily: "Billy",
//                     fontWeight: FontWeight.w600,color: Colors.yellow),
//               ),
//             ],
//           ),
//           Positioned(top: 10,right: 2,child: FancyTextReveal(child: GestureDetector( onTap: (){Get.to(Dashboard());},child: Text('Skip',style: TextStyle(decoration: TextDecoration.underline,fontSize: 20),)))),
//         ],
//       ),
//     ),
//     Container(
//       color: Colors.greenAccent,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Image.asset(
//             'assets/1.png',
//             fit: BoxFit.cover,
//           ),
//           Padding(padding: const EdgeInsets.all(20.0)),
//           Column(
//             children: <Widget>[
//               new Text(
//                 "Let's start safe",
//                 style: TextStyle(
//                     fontSize: 27,
//                     fontFamily: "Billy",
//                     fontWeight: FontWeight.bold,color: Colors.blueAccent),
//               ),
//               new Text(
//                 "journey together",
//                 style: TextStyle(
//                     fontSize: 27,
//                     fontFamily: "Billy",
//                     fontWeight: FontWeight.w600,color: Colors.blueAccent),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               new Text(
//                 "with GoSecure.",
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontFamily: "Billy",
//                     fontWeight: FontWeight.bold,color: Colors.orange),
//               ),
//             ],
//           ),
//           Positioned(top: 10,right: 2,child: FancyTextReveal(child: GestureDetector(onTap: (){Get.to(Dashboard());},child: Text('Explore Now', style:TextStyle(decoration: TextDecoration.underline,fontSize: 20),)))),
//         ],
//       ),
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           body: LiquidSwipe(
//         pages: pages,
//         fullTransitionValue: 500,
//         enableSlideIcon: true,
//
//       ));
//   }
// }




import 'package:flutter/material.dart';
import 'package:gosecure/Dashboard/Dashboard.dart';
import 'package:gosecure/Onboarding/onboarding_contents.dart';
import 'package:gosecure/Onboarding/size_config.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }
  int _currentPage = 0;
  List colors = const [
    Color(0xffFFE5DE),
    Color(0xffDAD3C8),
    Color(0xffDCF6E6),
    Color(0xffccff90),
    Color(0xffffcdd2),
    Color(0xffb2dfdb),
    Color(0xffccff90),
    Color(0xffffecb3),
  ];

  AnimatedContainer _buildDots({
    int index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW;
    double height = SizeConfig.screenH;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV * 35,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 60 : 30,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 24 : 35,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          contents[i].desc,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w300,
                            fontSize: (width <= 550) ? 17 : 25,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                          (int index) => _buildDots(
                        index: index,
                      ),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Padding(
                    padding: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()));
                      },
                      child: const Text("Start Your Safe Journey",textAlign: TextAlign.center,),
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: (width <= 550)
                            ? const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 17)
                            : EdgeInsets.symmetric(
                            horizontal: width * 0.2, vertical: 22),
                        textStyle:
                        TextStyle(fontSize: (width <= 550) ? 13 : 17),
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _controller.jumpToPage(7);
                          },
                          child: const Text(
                            "SKIP",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 13 : 17,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Text("NEXT"),
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 0,
                            padding: (width <= 550)
                                ? const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)
                                : const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 25),
                            textStyle: TextStyle(
                                fontSize: (width <= 550) ? 13 : 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
