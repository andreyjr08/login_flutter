// To parse this JSON data, do
//
//     final personaModel = personaModelFromJson(jsonString);

import 'dart:convert';

PersonaModel personaModelFromJson(String str) =>
    PersonaModel.fromJson(json.decode(str));

String personaModelToJson(PersonaModel data) => json.encode(data.toJson());

class PersonaModel {
  PersonaModel({
    this.id,
    this.nombre,
    this.apellido,
    this.direccion,
    this.telefono,
    this.fechaNacimiento,
    this.estado = "A"
  });

  int id;
  String nombre;
  String apellido;
  String direccion;
  String telefono;
  String fechaNacimiento;
  String estado;

  factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        fechaNacimiento: json["fecha_nacimiento"],
        estado: json["estado"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "telefono": telefono,
        "fecha_nacimiento":fechaNacimiento.toString(),
         "estado": estado
      };
}