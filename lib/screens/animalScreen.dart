import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/animal.dart';

import 'package:flutter/cupertino.dart';
import 'package:zampapp_mobile/models/animal.dart';

class AnimalScreen extends StatelessWidget {
  final Animal animal;

  AnimalScreen(this.animal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ZampApp - " + animal.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(animal.picture),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(animal.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Container(height: 5),
                  Text("Razza: " + animal.breed,
                      style: TextStyle(fontSize: 15)),
                  Text("Sesso: " + (animal.sex ? "maschio" : "femmina"),
                      style: TextStyle(fontSize: 15)),
                  Text("Sverminato: " + (animal.wormed ? "sí" : "no"),
                      style: TextStyle(fontSize: 15)),
                  Container(height: 5),
                  Text(animal.description, style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
