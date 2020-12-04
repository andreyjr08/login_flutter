import 'dart:convert';
import 'dart:io';
import 'package:form_validate/src/models/PersonaModel.dart';
import 'package:http/http.dart' as http;

class PersonaProvider {
  final String _url = "http://10.102.1.72:8080/persona";

  Future<bool> crearPersona(PersonaModel persona) async {
    final url = "$_url/crearPersona";

    final resp = await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: personaModelToJson(persona));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<PersonaModel>> listarPersonas() async {
    
    final url = '$_url/obtenerPersonas';
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<PersonaModel> personas = new List();

    if (decodeData == null) return [];

    List<dynamic> entitlements = decodeData["payload"];

    entitlements.forEach((valor) {
      if (valor['estado'] == 'A') {
        final persTemp = PersonaModel.fromJson(valor);
        personas.add(persTemp);
      }
    });

    return personas;
  }

  Future<int> inactivarPersona(int id) async {
    final url = '$_url/actualizarEstadoPersona';

    final body = jsonEncode({'id': id});

    final resp = await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: body);

    print(resp);

    print(json.decode(resp.body));

    return 1;
  }

    Future<bool> actualizarPersona(PersonaModel persona) async {
    final url = "$_url/actualizarPersona";

    final resp = await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: personaModelToJson(persona));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }
}
