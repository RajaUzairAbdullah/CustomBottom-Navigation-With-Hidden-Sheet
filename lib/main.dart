import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text;
  bool _state;

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _state = false;
    _text = 'TEST';
  }

  void _onVerticalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.up) {
        _state = true;
        print('Swiped up!');
      } else {
        _state = false;
        print('Swiped down!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // blurr work

    double _sigmaX = 3; // from 0-10
    double _sigmaY = 3; // from 0-10
    double _opacity = .1; // from 0-1.0
    double _width = 350;
    double _height = 300;

    // blurr work

    var width = MediaQuery.of(context).size.width * 0.95;
    var nav_height = MediaQuery.of(context).size.width / 6.5;
    var icon_height = nav_height / 2;

    var position = MediaQuery.of(context).size.width / 2;

    Widget navItem(String title) {
      return Column(
        mainAxisAlignment: _state == true
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _state == true
              ? Column(
                  children: [
                    Icon(
                      Icons.house_sharp,
                      color: Colors.white,
                      size: icon_height,
                    ),
                    Text(
                      title,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              : Column(
                  children: [
                    Icon(
                      Icons.house_sharp,
                      color: Colors.white,
                      size: icon_height,
                    )
                  ],
                )
        ],
      );
    }

    Widget HiddenSheet() {
      // starting
      var _myValue = 0.0;

      // ending
      final _myNewValue = 30.0;
      return Column(children: [
        Expanded(
            child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: AnimatedContainer(
            margin: EdgeInsets.only(bottom: 10),
            duration: Duration(milliseconds: 150),
            height: _state == true
                ? MediaQuery.of(context).size.width -
                    (MediaQuery.of(context).size.width * 0.2)
                : nav_height + _myValue,
            width: width,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              color: Colors.green,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Content Here",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ]);
    }

    Widget bottombar() {
      // starting
      var _myValue = 0.0;

      // ending
      final _myNewValue = 30.0;
      final positionvalue = 100;
      return AnimatedAlign(
        duration: Duration(milliseconds: 150),
        alignment: _state == true
            ? FractionalOffset.center
            : FractionalOffset.bottomCenter,
        child: AnimatedContainer(
          margin: EdgeInsets.only(bottom: 10),
          duration: Duration(milliseconds: 150),
          height: _state == true ? nav_height + _myNewValue : nav_height + 10,
          width: width,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(28.0),
            color: Colors.green,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [navItem("Home"), navItem("Wishlist"), navItem("Shop")],
          ),
        ),
      );
    }

    Widget bottomnav() {
      return Stack(
        children: [HiddenSheet(), bottombar()],
      );
    }

    PageController _controller = PageController(
      initialPage: 0,
    );

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Custom Navigation"),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
                  color: Colors.black.withOpacity(_opacity),
                  child: PageView(
                    controller: _controller,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                        child: Image.asset(
                          'assets/images/image.png',
                          width: _width,
                          height: _height,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                        child: Image.asset(
                          'assets/images/image2.png',
                          width: _width,
                          height: _height,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
          Positioned(
              width: _state == true ? MediaQuery.of(context).size.width : 0,
              height: _state == true ? MediaQuery.of(context).size.height : 0,
              // Note: without ClipRect, the blur region will be expanded to full
              // size of the Image instead of custom size
              child: ClipRect(
                  child: BackdropFilter(
                      filter: _state == true
                          ? ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY)
                          : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: Container(
                        color: Colors.black.withOpacity(_opacity),
                      )))),
          SimpleGestureDetector(
            onVerticalSwipe: _onVerticalSwipe,
            swipeConfig: SimpleSwipeConfig(
              verticalThreshold: 40.0,
              horizontalThreshold: 40.0,
              swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
            ),
            child: bottomnav(),
          ),
        ],
      ),
    );
  }
}
