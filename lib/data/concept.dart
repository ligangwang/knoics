class Concept{
  String name;
  String description;

  Concept(this.name, this.description);

  factory Concept.fromJson(String name, String description){
    return Concept(name, description);
  }
}