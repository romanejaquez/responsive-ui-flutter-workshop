import 'package:flutter/material.dart';

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TestMediaQueryWidget()
      ),
    );
  }
}

class TestMediaQueryWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // TODO: Step #1: Extract the MediaQueryData from MediaQuery.of

    return Stack(
      children: [
        HorizontalSizeIndicator(/* TODO: Step #2: populate the mediaQueryData param */),
        VerticalSizeIndicator(/* TODO: Step #2: populate the mediaQueryData param */)
      ]
    );
  }
}

class HorizontalSizeIndicator extends StatelessWidget {
  
  // Hm, tricky one! These mediaQueryData object feel like they should be
  // non-nullable and required. Otherwise, you have to use the ! operator below
  // to get the size. However, I understand that also causes DartPad to show the
  // missing arguments errors instead of just the Todos... Not sure the best
  // solution here :)
  final MediaQueryData? mediaQueryData;

  const HorizontalSizeIndicator({ Key? key, this.mediaQueryData }): super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // TODO: Step #3 - get the height and width out of the mediaQueryData.size
    var height = 0;
    var width = 0;

    return Stack(
      children: [
        Positioned(
          top: height / 2,
          left: -6,
          child: const Icon(
            Icons.west,
            color: Colors.green,
            size: 80
          )
        ),
        Positioned(
          top: height / 2,
          right: -6,
          child: const Icon(
            Icons.east,
            color: Colors.green,
            size: 80
          )
        ),
        Positioned(
          top: (height / 2) + 36,
          left: 0,
          right: 0,
          child: Container(
            height: 8,
            color: Colors.green,
            margin: const EdgeInsets.only(left: 12, right: 12)
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 50, bottom: 30),
            child: Text('$width',
                        style: const TextStyle(fontSize: 60, color: Colors.green))
          )
        )
      ]
    );
  }
}

class VerticalSizeIndicator extends StatelessWidget {
  
  // non-nullable?
  final MediaQueryData mediaQueryData;

  const VerticalSizeIndicator({ Key? key, required this.mediaQueryData }): super(key: key);

  @override
  Widget build(BuildContext context) {

    // TODO: Step #4 - get the height only out of the mediaQueryData.size
    var height = 0;
    
    return Stack(
      children: [
        const Positioned(
          top: -6,
          right: 24,
          child: Icon(
            Icons.north,
            color: Colors.red,
            size: 80
          ) 
        ),
        const Positioned(
          bottom: -6,
          right: 24,
          child: Icon(
            Icons.south,
            color: Colors.red,
            size: 80
          ) 
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 8,
            color: Colors.red,
            margin: const EdgeInsets.only(top: 12, bottom: 12, right: 60)
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Transform.rotate(
            angle: -1.55,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30, right: 100),
              child: Text('$height', 
                          style: const TextStyle(fontSize: 60, color: Colors.red))
            )
          )
        )
      ]
    );
  }
}