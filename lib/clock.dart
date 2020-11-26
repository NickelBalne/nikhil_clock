import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:nikhil_clock/clock_dail_painter.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  double hoursAngle = 0;
  double minutesAngle = 0;
  double secondsAngle = 0;

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {

      final now = DateTime.now();

      setState(() {
        secondsAngle = (math.pi / 30) * now.second;
        minutesAngle = math.pi / 30 * now.minute;
        hoursAngle = (math.pi / 6 * now.hour) + (math.pi / 45 * minutesAngle);
      });


    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        //Clock
        child: Stack(
          children: [

            Container(
              // color: Colors.black87,
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: MyPainter(),
              ),
            ),

            //dial and numbers go here
            Center(
              child: new Container(
                width: 300.0,
                height: 300.0,
                padding: const EdgeInsets.all(10.0),
                child:new CustomPaint(
                  painter: new ClockDialPainter(clockText: ClockText.roman),
                ),
              ),
            ),

            //Seconds Hand
            Transform.rotate(
              child: Container(
                child: Container(
                  height: 140,
                  width: 2,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                alignment: Alignment(0, -0.35),
              ),
              angle: secondsAngle,
            ),

            // Minutes Hand
            Transform.rotate(
              child: Container(
                child: Container(
                  height: 95,
                  width: 5,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                alignment: Alignment(0, -0.35),
              ),
              angle: minutesAngle,
            ),

            // Hour Hand
            Transform.rotate(
              child: Container(
                child: Container(
                  height: 70,
                  width: 7,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                alignment: Alignment(0, -0.2),
              ),
              angle: hoursAngle,
            ),

            //Clock Dot
            Container(
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              alignment: Alignment(0, 0),
            ),

          ],
        ),
        width: 370,
        height: 370,
        // decoration: BoxDecoration(
        //     border: Border.all(color: Colors.black45,width: 8),
        //     borderRadius: BorderRadius.circular(200)
        // ),
      ),
      color: Color.fromRGBO(8, 25, 35, 1),
      alignment: Alignment(0, 0),
    );
  }
}

class MyPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    double width = 5;
    var now = new DateTime.now();

    double centerX = size.width/2;
    double centerY = size.height/2;

    Paint secondPaint = Paint()..color=Colors.greenAccent..strokeWidth=width..strokeCap=StrokeCap.round..style=PaintingStyle.stroke;
    Paint minutePaint = Paint()..color=Colors.redAccent..strokeWidth=width..strokeCap=StrokeCap.round..style=PaintingStyle.stroke;
    Paint hourPaint = Paint()..color=Colors.blueAccent..strokeWidth=width..strokeCap=StrokeCap.round..style=PaintingStyle.stroke;

    //Hours,Minutes,Seconds Arc
    canvas.drawArc(new Rect.fromPoints(Offset(centerX-180, centerY-180), Offset(centerX+180, centerY+180)), -math.pi/2, math.pi*now.second/30, false, secondPaint);
    canvas.drawArc(new Rect.fromPoints(Offset(centerX-180+width+10, centerY-180+width+10), Offset(centerX+180-width-10, centerY+180-width-10)), -math.pi/2, math.pi*now.minute/30, false, minutePaint);
    canvas.drawArc(new Rect.fromPoints(Offset(centerX-180+2*(width+10), centerY-180+2*(width+10)), Offset(centerX+180-2*(width+10), centerY+180-2*(width+10))), -math.pi/2, math.pi*(now.hour%12)/6, false, hourPaint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}