import 'dart:math';

import 'package:flutter/material.dart';

class WaveWidget extends StatefulWidget {
  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 7000));
    _animation = Tween<double>(begin: 0, end:2*pi).animate(_animationController);

    _animationController.addListener(() {
      setState(() {

      });
    });
    _animationController.repeat();
    super.initState();
  }

  final double waveHeight = 300;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: waveHeight,
      child: Stack(
        children: [
          _oneBottle(.3), // -1 ~ 1
          _oneBottle(-.2),
          _oneBottle(-.7),
          _oneBottle(.6),
          Positioned.fill(
            child: Container(
                child: ClipPath(
                  clipper: WaveClipper(_animation.value),
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _oneBottle(double align){ // -1 ~ 1
    align = (align + 1)/2; // -1 ~ 1 -> 0 ~ 1
    var leftPos = MediaQuery.of(context).size.width * align - WaveClipper.bottleSize/2;
    var leftCenterPos = align * MediaQuery.of(context).size.width;
    var degree = cos(_animation.value + leftCenterPos * WaveClipper.waveDouble) * 45 * .3;
    return Positioned(
      left: leftPos,
      top:  WaveClipper.getYWithX(leftCenterPos.toInt(), _animation.value, topMargin: 0),
      child: RotationTransition(
          turns: AlwaysStoppedAnimation(degree/360),
          child: Image.asset('images/water-bottle.png', width: WaveClipper.bottleSize, height: WaveClipper.bottleSize)),
    );
  }
}


class WaveClipper extends CustomClipper<Path>{
  WaveClipper(this.animationValue);
  final double animationValue;

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var p = Path();
    var points = <Offset>[];
    for(var x = 0; x<size.width; x++)
      points.add(Offset(x.toDouble(), WaveClipper.getYWithX(x, animationValue)));

    p.moveTo(0, WaveClipper.getYWithX(0, animationValue));
    p.addPolygon(points, false);
    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);
    return p;
  }

  static const double waveHeight = 40;
  static const double bottleSize = 80;
  static const double waveDouble = 0.01;

  static double getYWithX(int x, double animationValue, {double topMargin = bottleSize/1.5}){ // 0 ~ 2pi
    var y = ((sin(animationValue + x * waveDouble) + 1)/2) * waveHeight + topMargin;// 0 ~ 1
    return y;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
