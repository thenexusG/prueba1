import 'package:flutter/material.dart';
import 'package:prueba1/Mascota.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'DatabaseHelper.dart';

class ScreenDetail extends StatefulWidget {
  final Mascota mascota;

  const ScreenDetail({Key key, this.mascota}) : super(key: key);

  @override
  _ScreenDetailState createState() => _ScreenDetailState(mascota);
}

class _ScreenDetailState extends State<ScreenDetail> {

  Mascota mascota;
  final edadTextController = TextEditingController();
  final nombreTextController = TextEditingController();

  bool isSwitched = false;

  _ScreenDetailState(this.mascota);

  @override
  void initState() {
    super.initState();
    if (mascota != null) {
      edadTextController.text = mascota.Edad;
      nombreTextController.text = mascota.Nombre;
    }
  }

  @override
  void dispose() {
    super.dispose();
    edadTextController.dispose();
    nombreTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar mascota'),
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
          onPressed: () async {
            _saveTodo(nombreTextController.text, edadTextController.text, isSwitched.toString());
            setState(() {});
          }),
    );
  }

  _saveTodo(String nombre, String edad, String vacunado) async {
    if (mascota == null) {
      DatabaseHelper.instance.insertMascota(Mascota(
        Nombre: nombreTextController.text,
        Edad: edadTextController.text,
        Vacunado: isSwitched.toString()));
      Navigator.pop(context, "Your todo has been saved.");
    } else {
      await DatabaseHelper.instance
          .updateMascota(Mascota(id: mascota.id, Nombre: nombre, Edad: edad, Vacunado: vacunado));
      Navigator.pop(context);
    }
  }

}
