import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:knoics/graph.dart';

class GraphLayout{
  GraphLayout(Graph graph, Size size){
    nodeLayouts = Map<String, NodeLayout>();
    graph.nodes.forEach((name, node)=>nodeLayouts[name]=NodeLayout(node, NodeLayout.getRandomizedPosition(size)));
    nodeLayouts.forEach((name, nodeLayout)=>nodeLayout.node.edges.forEach((edge)=>nodeLayout.edgeLayouts.add(EdgeLayout(edge: edge, toNodeLayout: nodeLayouts[edge.toNode.name]))));
    this.graph = graph;
    this.size = size;
  }

  Map<String, NodeLayout> nodeLayouts;
  Graph graph;
  Size size;

  void randomize(){
    print("graph layout size: ${this.size}");
    nodeLayouts.forEach((name, nodeLayout)=>nodeLayout.setRandomizedPosition(this.size));
  }

  String toString(){
    String nodes = "";
    for(var node in nodeLayouts.values){
      nodes += node.toString();
    }
    return nodes;
  }
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

  void setRandomizedPosition(size){
    position = getRandomizedPosition(size);
  }

  Map<String, NodeLayout> get neighbors{
    Map<String, NodeLayout> neighbors = Map<String, NodeLayout>();
    for(var edgeLayout in edgeLayouts){
      neighbors[edgeLayout.toNodeLayout.node.name] = edgeLayout.toNodeLayout;
    }
    return neighbors;
  }
  List<EdgeLayout> edgeLayouts;
  Offset position;
  Node node;

  String get name {
    return node.name;
  }

  String toString(){
    return "${node.name}: position: ${position}";
  }
}

class EdgeLayout{
  EdgeLayout({this.edge, this.toNodeLayout});
  Edge edge;
  NodeLayout toNodeLayout;
}
