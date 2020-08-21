import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'dart:async';
import 'package:after_layout/after_layout.dart';

void main() {
  runApp(App());
}

// TODO: Alert dialogue + animated container, watch french vid that has slow mo of what is happening.
// TODO: medium article on getting position and height of
// TODO: Make a function that adds items to shopList when they're chosen for the shop.
// TODO: Make a class for the user that includes the balance and a list of things they own
// TODO: Change price to type int to do maths

/// Staggered Animation

//GET SIZE
class Sizer {
  static double height;
  static double width;
}

class ScreenMeasure {
  static double screenHeight;

}

class BarSizer {
  static double height = 12.0;
  static double width = 12.0;
}

//APP
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin<MyApp> {
  final GlobalKey _keySize = GlobalKey();
  final GlobalKey _keyBar = GlobalKey();

  sizeHeight(GlobalKey globalKey) {
    final RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    final widgetHeight = renderBoxRed.size.height;
    return widgetHeight;
  }

  sizeWidth(GlobalKey globalKey) {
    final RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    final widgetWidth = renderBoxRed.size.width;
    return widgetWidth;
  }

//    print("SIZE of Red: $widgetHeight");
//    print('width of widget: $widgetWidth');

  //// Large Item Lists

  final itemList = [
    LargeItem(
        image: 'assets/campervan.png',
        item: 'Campervan',
        price: '2000',
        colour: Color(0xff355c7d)),
    LargeItem(
      image: 'assets/barbecue.png',
      item: 'Barbecue',
      price: '2000',
      colour: Color(0xffd74153),
    ),
    LargeItem(
      image: 'assets/campfire.png',
      item: 'Campfire',
      price: '2000',
      colour: Color(0xffD8B661),
    ),
  ];

  final shopItem = [];

  LargeItem randomItem() {
    Random random = Random();
    int randomNumber = random.nextInt(3);
    shopItem.add(randomNumber);

    return itemList[randomNumber];
  }

  //// Small Item Lists

  // Common
  // Rare
  // Golden

//// List of items that have been added to Shop

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    print('initMyApp');
    showDialog(
      useSafeArea: false,
      barrierColor: Colors.black.withOpacity(0.01),
      context: context,
      builder: (context) => new StaggeredAnimationReplication(),



    );    setState(() {
      Sizer.height = sizeHeight(_keySize);
      Sizer.width = sizeWidth(_keySize);

      BarSizer.height = sizeHeight(_keyBar) + 16;
      BarSizer.width = sizeWidth(_keyBar);
    });
  }

  Widget build(BuildContext context) {
    ScreenMeasure.screenHeight = MediaQuery.of(context).size.height*0.70;
    print('build MyApp' + BarSizer.height.toString());
    return MaterialApp(
        home: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                key: _keyBar,
                backgroundColor: Color(0xff212C3D),
                title: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Item Shop',
                            style: TextStyle(fontSize: 25),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/inv_seed.png',
                                  height: 18,
                                ),
                                Padding(
                                    child: Text(
                                        '5300', style: TextStyle(fontSize: 23)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5)),
                              ],
                            ),
                          ),
                        ])),
              ),
              body: Stack(
                children: [
                  Container(
                    color: Color(0xff212C3D),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 17),
                              child: Row(children: [
                                Expanded(
                                  key: _keySize,
                                  child: Container()
                                ),
                              ]),
                            ),
                          ),
                          Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SmallItem(
                                      image: 'assets/barbecue.png',
                                      item: 'Barbecue',
                                      price: '800',
                                      colour: Color(0xffd74153),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: SmallItem(
                                      image: 'assets/campfire.png',
                                      price: "1200",
                                      item: 'Campfire',
                                      colour: Color(0xffD8B661),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ],
        ));
  }
}

class LargeItem extends StatelessWidget {
  final String image;
  final String item;
  final String price;
  final Color colour;

  const LargeItem({
    Key key,
    this.image,
    this.item,
    this.price,
    this.colour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colour,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 42, left: 22, right: 22),
                  child: Image.asset(image))),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Material(
                            type: MaterialType.transparency,
                            child: Text(
                              item,
                              style: TextStyle(
                                  fontSize: 46.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(children: <Widget>[
                        Image.asset(
                          'assets/streak_seed.png',
                          height: 19,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              price,
                              style: TextStyle(
                                  fontSize: 26.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class StaggeredAnimationReplication extends StatefulWidget {
  @override
  _StaggeredAnimationReplicationState createState() =>
      new _StaggeredAnimationReplicationState();
}

class _StaggeredAnimationReplicationState
    extends State<StaggeredAnimationReplication>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    print("stagger");

    controller = new AnimationController(vsync: this);

    sequenceAnimation = new SequenceAnimationBuilder()
        .addAnimatable(
        animatable: new EdgeInsetsTween(
          begin: EdgeInsets.only(top: BarSizer.height),
          end: const EdgeInsets.only(top: 0.0),
        ),
        from: const Duration(milliseconds: 0),
        to: const Duration(milliseconds: 550),
        curve: Curves.easeInBack,
        tag: "topMargin")
        .addAnimatable(
        animatable: new EdgeInsetsTween(
          begin: EdgeInsets.only(top: BarSizer.height),
          end: const EdgeInsets.only(top: 0.0),
        ),
        from: const Duration(milliseconds: 0),
        to: const Duration(milliseconds: 550),
        curve: Curves.easeInBack,
        tag: "contentMargin")
        .addAnimatable(
        animatable: new Tween<double>(begin: Sizer.height, end: ScreenMeasure.screenHeight),
        from: const Duration(milliseconds: 0),
        to: const Duration(milliseconds: 650),
        curve: Curves.easeInBack,
        tag: "height")

    /// We add this below bit so that it doesn't stop abruptly (cleaner).
        .addAnimatable(
        animatable: new Tween<double>(begin: ScreenMeasure.screenHeight, end: ScreenMeasure.screenHeight+50),
        from: const Duration(milliseconds: 650),
        to: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        tag: "height")
        .addAnimatable(
        animatable: new Tween<double>(begin: Sizer.height, end: 1000),
        from: const Duration(milliseconds: 0),
        to: const Duration(milliseconds: 650),
        curve: Curves.easeInBack,
        tag: "contentHeight")
        .addAnimatable(
        animatable: new EdgeInsetsTween(
          begin: const EdgeInsets.symmetric(horizontal: 16.0),
          end: const EdgeInsets.symmetric(horizontal: 0.0),
        ),
        from: const Duration(milliseconds: 100),
        to: const Duration(milliseconds: 650),
        curve: Curves.easeInBack,
        tag: "sideMargin")
        .addAnimatable(
        animatable: new BorderRadiusTween(
          begin: new BorderRadius.circular(15.0),
          end: new BorderRadius.circular(0.0),
        ),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        tag: "borderRadius")
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Column(children: [
      Expanded(
        child: Container(
          margin: sequenceAnimation["sideMargin"].value,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [

                    ///Item Container
                    Container(
                        decoration: BoxDecoration(
                            color: Color(0xff1F1C22),
                            borderRadius:
                            sequenceAnimation["borderRadius"].value),
                        margin: sequenceAnimation["contentMargin"].value,
                        height: sequenceAnimation["contentHeight"].value),

                    ///Content Container
                    Container(
                        child: ClipRRect(
                            borderRadius:
                            sequenceAnimation["borderRadius"].value,
                            child: LargeItem(
                                image: 'assets/campervan.png',
                                item: 'Campervan',
                                price: '2000',
                                colour: Color(0xff355c7d))),
                        alignment: Alignment.topCenter,
                        height: sequenceAnimation["height"].value,
                        margin: sequenceAnimation["topMargin"].value),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  Future<Null> _playAnimation() async {
    try {
      await controller
          .forward()
          .orCancel;
//      await new Future.delayed(const Duration(seconds: 2));
////      await controller
////          .reverse()
////          .orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }
  Future<Null> _reverseAnimation() async {
    try {
      await controller
          .reverse()
          .orCancel;
    } on TickerCanceled {}
  }

  //// Small Item Lists

  // Common
  // Rare
  // Golden

//// List of items that have been added to Shop
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            child: GestureDetector(
                onTap: () {
                  _playAnimation();
                }, onVerticalDragStart: (DragStartDetails details){ _reverseAnimation();},
                child: Container(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: _buildAnimation,
                    )))));
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
          child: Stack(children: [MyApp(), ])),
    );
  }
}

class SmallItem extends StatelessWidget {
  final String image;
  final String item;
  final String price;
  final Color colour;

  const SmallItem({
    Key key,
    this.image,
    this.item,
    this.price,
    this.colour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {},
      color: colour,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.asset(image))),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              item,
                              style: TextStyle(
                                  fontSize: 23.0, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(children: [
                          Image.asset(
                            'assets/streak_seed.png',
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Text(
                              price,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
