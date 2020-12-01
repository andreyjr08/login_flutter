import 'dart:convert';

import 'package:form_validate/src/models/PersonaModel.dart';
import 'package:http/http.dart' as http;

class PersonaProvider {
  
  final String _url = "http://10.102.1.72:8080/persona";

  Future<bool> crearPersona( PersonaModel persona) async {

    final url = "$_url/crearPersona";

    final resp = await http.post( url, body: personaModelToJson(persona));

    print(url);

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }
}
