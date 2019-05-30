import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Graph extends CustomPaint{
  Graph() : super(painter: GraphPainter(), child:Center());
}

class GraphPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
    ..color=Colors.grey
    ..strokeWidth=3.0
    ..style=PaintingStyle.fill;
    canvas.drawLine(Offset.zero, size.center(Offset.zero), paint);
    paint.color=Colors.green;
    canvas.drawCircle(size.center(Offset.zero), 20.0, paint);
    var ts =  TextSpan(style: TextStyle(color: Colors.white), text: 'math');
    var tp =  TextPainter(text: ts, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,  size.center(Offset.zero) - tp.size.center(Offset.zero));
  }
  
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
  
}


class NodePainter extends CustomPainter{
  final String name;
  NodePainter({this.name});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
    ..color=Colors.grey
    ..strokeWidth=3.0
    ..style=PaintingStyle.fill;
    canvas.drawLine(Offset.zero, size.center(Offset.zero), paint);
    paint.color=Colors.green;
    canvas.drawCircle(size.center(Offset.zero), 20.0, paint);
    TextSpan span =  TextSpan(style:  TextStyle(color: Colors.red), text: 'Yrfc');
    TextPainter tp =  TextPainter(text: span, textAlign: TextAlign.left);
    tp.layout();
    tp.paint(canvas,  Offset(5.0, 5.0));
  }
  
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
  
}