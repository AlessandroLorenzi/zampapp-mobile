import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/animal.dart';
import '../models/user.dart';

class ZampAppApi {
  String baseUri = 'https://zampapp.alorenzi.eu:8443';

  ZampAppApi() {
    this.baseUri = "https://zampapp.alorenzi.eu:8443";
  }

  Future<List<Animal>> getAnimals() async {
    final resp = await http.get(baseUri + '/api/animals');
    if (resp.statusCode != 200) {
      return null;
    }
    final respJson = jsonDecode(resp.body);
    final animalsMap = respJson['animals'];
    return animalsMap.map<Animal>((animal) => Animal.fromMap(animal)).toList();
  }


  Future<String> login(String login, String password) async {
    final Map<String,dynamic>loginData = { "login":login, "password":password };
    final loginJson =  jsonEncode(loginData);
    final resp = await http.post(
        baseUri + '/api/login',
        body: loginJson,
    );


    final respMap = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      return  respMap["token"];
    }
    throw respMap["message"];
  }

  Future<User> getUser(String userID) async {
    final resp = await http.get(baseUri + '/api/user/'+userID);
    if (resp.statusCode != 200) {
      print("user id "+userID+ " status code: "+  resp.statusCode.toString());
      return null;
    }
    final respJson = jsonDecode(resp.body);
    final userMap = respJson['user'];
    return User.fromMap(userMap);
  }
}

