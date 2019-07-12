import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:knoics/graph.dart';
import 'package:knoics/graph_layout.dart';
import 'package:knoics/ham.dart';

class GraphWidget extends CustomPaint{
  GraphWidget(Graph graph) : super(painter: _GraphPainter(graph), child:Center());
}

class _GraphPainter extends CustomPainter{
  Graph _graph;
  Paint _paint;
  GraphLayout _graphLayout;
  bool _isLayoutDone;
  _GraphPainter(Graph graph){
    _graph = graph;
    _graphLayout = null;
    _paint = Paint()
    ..color=Colors.grey
    ..strokeWidth=3.0
    ..style=PaintingStyle.fill
    ..color=Colors.green;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if(_graphLayout==null){
      _graphLayout = GraphLayout(_graph, size);
      _graphLayout.randomize();
      _isLayoutDone = false;
    }
    if(!_isLayoutDone){
      _isLayoutDone = HyperassociativeMap.layout(_graphLayout, 100);
//      print('layout !!! ${_isLayoutDone}');
    }
    //print(graphLayout);
    _paint.color=Colors.grey;
    _graphLayout.nodeLayouts.forEach((name, nodeLayout)=>_paintEdge(canvas, nodeLayout));

    _paint.color = Colors.green;
    _graphLayout.nodeLayouts.forEach((name, nodeLayout)=>_paintNode(canvas, nodeLayout));
  }
  
  void _paintEdge(Canvas canvas, NodeLayout nodeLayout){
    nodeLayout.edgeLayouts.forEach((edgeLayout)=>canvas.drawLine(nodeLayout.position, edgeLayout.toNodeLayout.position, _paint));
  }

  void _paintNode(Canvas canvas, NodeLayout nodeLayout){
    canvas.drawCircle(nodeLayout.position, NodeLayout.Radius, _paint);
    var ts =  TextSpan(style: TextStyle(color: Colors.white), text: nodeLayout.node.name);
    var tp =  TextPainter(text: ts, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,  nodeLayout.position - tp.size.center(Offset.zero));
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    //print('_isLayoutDone: ${_isLayoutDone}');
    return !_isLayoutDone;
  }
  
}
