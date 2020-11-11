import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zampapp_mobile/screens/statefulAnimal.dart';
import 'package:zampapp_mobile/zampappapi/zampappapi.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController txtLogin = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    checkIfLoggedIn();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Container(
              height: 250,
            ),
            TextField(
              controller: txtLogin,
              decoration: InputDecoration(
                hintText: "email",
              ),
            ),
            TextField(
              controller: txtPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "password",
              ),
            ),
            ElevatedButton(
              onPressed: doLogin,
              child: Text("login"),
            ),
            FlatButton(
              onPressed: () {},
              color: Colors.white,
              highlightColor: Colors.white,
              colorBrightness: Brightness.dark,
              child: Text(
                "Sei nuovo? Registrati!",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkIfLoggedIn() async {
    final _storage = FlutterSecureStorage();
    String token = await _storage.read(key: "jwt");
    if (token == null) {
      return;
    }
    goToMainApp(this.context, token);
  }

  void goToMainApp(BuildContext context, String token) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return StatefulAnimalWidget(token);
    }));
  }

  void doLogin() {
    final api = ZampAppApi();
    print("Login! " + txtLogin.text);
    api.login(txtLogin.text, txtPassword.text).then((jwt) {
      final _storage = FlutterSecureStorage();
      _storage.write(key: "jwt", value: jwt).then((_) {
        goToMainApp(this.context, jwt);
      }).catchError((onError) {
        displayDialog(
            this.context, "Errore", "Impossibile salvare il token in locale");
      });
    }).catchError((onError) {
      print("Error login: " + onError.toString());
      displayDialog(this.context, "Errore", "Password o utente non validi.");
    });
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
}
