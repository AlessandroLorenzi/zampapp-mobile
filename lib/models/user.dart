class User {
  String id;
  String picture;
  String email;
  String nickname;
  String description;

  User.fromMap(Map<String,dynamic> mapData){
    this.id = mapData['id'];
    this.picture = mapData['picture'];
    this.email = mapData['email'];
    this.nickname = mapData['nick_name'];
    this.description = mapData['description'];
  }
}
