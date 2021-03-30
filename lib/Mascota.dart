class Mascota{
  final int id;
  // ignore: non_constant_identifier_names
  final String Nombre;
  // ignore: non_constant_identifier_names
  final String Edad;
  // ignore: non_constant_identifier_names
  final String Vacunado;
  static const String TABLENAME = "mascotas";

  // ignore: non_constant_identifier_names
  Mascota({this.id, this.Nombre, this.Edad, this.Vacunado});

  Map<String, dynamic> toMap() {
    return {'id': id, 'Nombre': Nombre, 'Edad': Edad, 'Vacunado': Vacunado};
  }
}