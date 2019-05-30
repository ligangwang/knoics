import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GraphWidget extends CustomPaint{
  GraphWidget(Graph graph) : super(painter: _GraphPainter(graph), child:Center());
}

class Graph{
  Graph(){
    _nodes = Map<String, Node>();
    addEdge('physics', 'subclass', 'natural sci.');
    addEdge('natural sci.', 'subclass', 'science');
  }
  Map<String, Node> _nodes;
  Map<String, Node> get nodes{return _nodes;}

  void addEdge(String fromName, String attribute, String toName){
    Node fromNode = _createAndGetNode(fromName);
    Node toNode = _createAndGetNode(toName);
    fromNode.addEdge(Edge(attribute: attribute, toNode: toNode));
  }

  Node _createAndGetNode(String nodeName){
    if (_nodes.containsKey(nodeName)){
      return _nodes[nodeName];
    }
    else{
      var node = Node(nodeName);
      _nodes[nodeName] = node;
      return node;
    }
  }
}

class Node{
  Node(name){
    this.name = name;
    this._edges = List<Edge>();
  }
  String name;
  List<Edge> _edges;

  List<Edge> get edges{return _edges;}
  void addEdge(Edge edge){
    _edges.add(edge);
  }
}

class Edge{
  Edge({this.attribute, this.toNode});
  String attribute;
  Node toNode;
}

class GraphLayout{
  GraphLayout(Graph graph, Size size){
    nodeLayouts = Map<String, NodeLayout>();
    graph.nodes.forEach((name, node)=>nodeLayouts[name]=NodeLayout(node, NodeLayout.getRandomizedPosition(size)));
    nodeLayouts.forEach((name, nodeLayout)=>nodeLayout.node.edges.forEach((edge)=>nodeLayout.edgeLayouts.add(EdgeLayout(edge: edge, toNodeLayout: nodeLayouts[edge.toNode.name]))));
    graph = graph;
    size = size;
  }

  Map<String, NodeLayout> nodeLayouts;
  Graph graph;
  Size size;
}

class NodeLayout{
  static const double Radius = 30;
  static const Offset RadiusOffset = Offset(Radius, Radius);
  NodeLayout(Node node, Offset position){
    this.node = node;
    this.position = position;
    this.edgeLayouts = List<EdgeLayout>();
  }

  static Offset getRandomizedPosition(size){
    var maxOffset = size.bottomRight(-RadiusOffset);
    var minOffset = RadiusOffset;
    Offset sz = maxOffset - minOffset;
    return sz.scale(Random().nextDouble(), Random().nextDouble());
  }
  List<EdgeLayout> edgeLayouts;
  Offset position;
  Node node;
}

class EdgeLayout{
  EdgeLayout({this.edge, this.toNodeLayout});
  Edge edge;
  NodeLayout toNodeLayout;
}

class _GraphPainter extends CustomPainter{
  Graph _graph;
  Paint _paint;
  _GraphPainter(Graph graph){
    _graph = graph;
    _paint = Paint()
    ..color=Colors.grey
    ..strokeWidth=3.0
    ..style=PaintingStyle.fill
    ..color=Colors.green;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var graphLayout = GraphLayout(_graph, size);
    _paint.color=Colors.grey;
    graphLayout.nodeLayouts.forEach((name, nodeLayout)=>_paintEdge(canvas, nodeLayout));

    _paint.color = Colors.green;
    graphLayout.nodeLayouts.forEach((name, nodeLayout)=>_paintNode(canvas, nodeLayout));
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
    return false;
  }
  
}
