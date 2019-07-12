/// Implements Jeffrey Freeman's algorithm in dart.
/// ref: http://jeffreyfreeman.me/hyperassociative-map-explanation/
/// 

import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:knoics/graph_layout.dart';
class HyperassociativeMap{
  static double maxMovement = 0.0;
  static const double EQUILIBRIUM_DISTANCE = 100.0; //chi
  static const double REPULSIVE_WEAKNESS = 2.0;   //delta
  static const double DEFAULT_LEARNING_RATE = 0.4; //0.05; //eta
  static const double EQUILIBRIUM_ALIGNMENT_FACTOR = 0.005; //beta
  
  static bool layout(GraphLayout g, int iterateCountLimit){
    // var stopWatch = Stopwatch();
    // stopWatch.start();
    int iterateCount = 0;
    var equilibriumAlignment = EQUILIBRIUM_DISTANCE * EQUILIBRIUM_ALIGNMENT_FACTOR;
    print("equilibrium distance of move: ${equilibriumAlignment}");
    while (true){
      iterateCount ++;
      maxMovement = 0.0;
      Offset center = processLocally(g);
      center /= g.nodeLayouts.length.toDouble();
      recenterNodes(g, center);
      if (maxMovement < equilibriumAlignment)
        return true;
      if (iterateCount==iterateCountLimit)
        return false;
    }
    // stopWatch.stop();
    // print("iterateCount: ${iterateCount}, ${stopWatch.elapsedMicroseconds}");
  }

  static void recenterNodes(GraphLayout g, Offset nodesCenter){
    Offset layoutCenter = g.size.center(Offset.zero);
    Offset moveToCenter = layoutCenter - nodesCenter;
    g.nodeLayouts.forEach((String name, NodeLayout node){
      node.position += moveToCenter;
    });
  }

  static Offset processLocally(GraphLayout g) {
        Offset pointSum = Offset.zero;
        for (final NodeLayout node in g.nodeLayouts.values) {
          var movement = align(g, node);
          var moveDistance = movement.distance;
          if (moveDistance > maxMovement) {
              maxMovement = moveDistance;
          }
          node.position += movement;
          pointSum += node.position;
        }
        return pointSum;
    }

  static Iterable<NodeLayout> neighbors(NodeLayout n){
    return n.neighbors.values;
  }

  static Iterable<NodeLayout> nonNeighbors(GraphLayout g, NodeLayout n) sync* {
    var neighbors = n.neighbors;
    for(NodeLayout node in g.nodeLayouts.values){
        if (!neighbors.containsKey(node.name) && node.name != n.name)
          yield node;
    }
  }

  static  Map<String, double> getNeighbors(final NodeLayout nodeToQuery) {
        final Map<String, double> neighbors = Map<String, double>();
        for (final NodeLayout n in nodeToQuery.neighbors.values){
          neighbors[n.name] = EQUILIBRIUM_DISTANCE;
          assert(nodeToQuery.name != n.name);
        }
        return neighbors;
    }

  static Offset setDistance(Offset v, double distance){
      double ratio = distance / v.distance;
      v = v.scale(ratio, ratio);
      return v;
  }

  static Offset align(final GraphLayout g, final NodeLayout nodeToAlign) {
        // calculate equilibrium with neighbors
        final Offset location = nodeToAlign.position;
        final Map<String, double> neighbors = getNeighbors(nodeToAlign);

        Offset compositeVector = Offset.zero;
        // align with neighbours
        neighbors.forEach((String nodeName, double distance){
          var neighbor = g.nodeLayouts[nodeName];
          var neighborVector = neighbor.position - location;
          double newDistance = (neighborVector.distance - distance) * DEFAULT_LEARNING_RATE;
          neighborVector = setDistance(neighborVector, newDistance);
          compositeVector += neighborVector;
        });
        
        // calculate repulsion with all non-neighbors
        g.nodeLayouts.forEach(
          (String nodeName, NodeLayout node){
            if(!neighbors.containsKey(nodeName) && nodeName != nodeToAlign.name){
              Offset nodeVector = node.position - location;
              double newDistance = -nodeVector.distance / pow(nodeVector.distance, REPULSIVE_WEAKNESS + 1);
              if (newDistance.abs() > EQUILIBRIUM_DISTANCE){
                newDistance = -EQUILIBRIUM_DISTANCE;
              }
              newDistance *= DEFAULT_LEARNING_RATE;
              nodeVector = setDistance(nodeVector, newDistance);
              compositeVector += nodeVector;
            }
          }
        );

        return compositeVector;    
    }
}
