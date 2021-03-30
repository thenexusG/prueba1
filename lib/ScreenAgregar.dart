import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prueba1/Mascota.dart';
import 'DatabaseHelper.dart';

import 'package:flutter_switch/flutter_switch.dart';

class CreateMascotaScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddState();
  }
}

class _AddState extends State<CreateMascotaScreen> {
  final edadTextController = TextEditingController();
  final nombreTextController = TextEditingController();

  bool isSwitched = false;

  @override
  void dispose() {
    super.dispose();
    nombreTextController.dispose();
    edadTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Mascota'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Nombre"),
              maxLines: 1,
              controller: nombreTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: new InputDecoration(labelText: "Edad"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              controller: edadTextController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("¿Su mascota esta vacunado?"),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                          activeColor: Colors.green,
                          value: isSwitched,
                          onToggle: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          }),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   child: Text(
                      //     "Value: $isSwitched",
                      //   ),
                      // ),
                    ],
                  ),
                ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            DatabaseHelper.instance.insertMascota(Mascota(
              Nombre: nombreTextController.text,
              Edad: edadTextController.text,
              Vacunado: isSwitched.toString(),
            ));
            Navigator.pop(context, "Datos registrados");
          }),
    );
  }
}
