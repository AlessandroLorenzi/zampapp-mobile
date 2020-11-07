class Animal {
  String id;
  String name;
  String breed;
  String description;
  String picture;
  int size;
  bool sex;
  bool wormed;
  bool childFriendly;
  Location position;
  String positionDesc;

  Animal.fromMap(Map<String,dynamic> mapData){
    this.id = mapData['id'];
    this.name = mapData['name'];
    this.breed = mapData['breed'];
    this.picture = mapData['picture'];
    this.description = mapData['description'];
    this.size = mapData['size'];
    this.sex = mapData['sex'];
    this.wormed = mapData['wormed'];
    this.childFriendly = mapData['childFriendly'];
    this.position = Location( mapData['position']['x'], mapData['position']['y']);
    this.positionDesc = mapData['positionDesc'];
  }
}

class Location{
  double x;
  double y;

  Location(this.x, this.y);
}

