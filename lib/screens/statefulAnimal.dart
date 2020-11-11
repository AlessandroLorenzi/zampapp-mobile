import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:zampapp_mobile/models/user.dart';
import 'package:zampapp_mobile/screens/sideMenu.dart';
import 'package:zampapp_mobile/zampappapi/zampappapi.dart';
import '../models/animal.dart';
import './animalScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'loginScreen.dart';



class StatefulAnimalWidget extends StatefulWidget {
  final String jwtToken;
  StatefulAnimalWidget(this.jwtToken);

  @override
  _StatefulAnimalState createState() => _StatefulAnimalState(this.jwtToken);
}

class _StatefulAnimalState extends State<StatefulAnimalWidget> {
  List<Animal> animals = List<Animal>();
  User loggedInUser;
  String jwtToken;

  _StatefulAnimalState(this.jwtToken);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer:  SideMenu(
          onLogoutChanged: (){logoutAndGoToLogin(context);},
          loggedUser: this.loggedInUser
      ),
      appBar: AppBar(
        title:Text('ZampApp'),
      ),
      body: ListView.builder(
        itemCount: animals.length,
        itemBuilder: buildAnimalsList,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: fetchAnimals,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    fetchAnimals();
    fetchUser();
    super.initState();
  }

  Widget buildAnimalsList(BuildContext context, int position) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: Column(
          children: [
            Text(
              animals[position].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              animals[position].breed,
              textAlign: TextAlign.left,
            ),
            GestureDetector(
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => AnimalScreen(animals[position]));
                Navigator.push(context, route);
              },
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: new Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.center,
                      image: new NetworkImage(animals[position].picture),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchAnimals() async {
    try {
      ZampAppApi zampappapi = ZampAppApi();
        animals = await zampappapi.getAnimals();
      setState(() {
        animals = animals;
      });
    } catch (onError) {
      print("Fetch error: " + onError.toString());
    }
  }

  void fetchUser() async {
    try {
      final _storage = FlutterSecureStorage();
      String token = await _storage.read(key: "jwt");
      // if (! validJWT(token)){
      //   logoutAndGoToLogin(context);
      // }
      
      ZampAppApi zampappapi = ZampAppApi();
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(this.jwtToken);
      final userID = decodedToken["user_id"];
      print(userID);

      final user = await zampappapi.getUser(userID);
      print("da user " + user.nickname);
      setState(() {
        loggedInUser = user;
      });

    } catch (onError) {
      print("Fetch error: " + onError.toString());
    }
  }

  bool validJWT(String jwtToken) {
    final bool hasExpired = JwtDecoder.isExpired(jwtToken);
    if (hasExpired) {
      return false;
    }
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
    if (decodedToken["user_id"] != ""){
      return true;
    }
    return false;
  }

  void logoutAndGoToLogin(BuildContext context) async {
    final _storage = FlutterSecureStorage();
    _storage.delete(key: "jwt");

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }
}
