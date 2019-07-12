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
