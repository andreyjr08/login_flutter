import 'package:flutter/material.dart';
import 'package:form_validate/src/models/PersonaModel.dart';
import 'package:form_validate/src/providers/persona_provider.dart';
import 'package:form_validate/src/utils/utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class PersonaPage extends StatefulWidget {
  @override
  _PersonaPageState createState() => _PersonaPageState();
}

class _PersonaPageState extends State<PersonaPage> {
  final formKey = GlobalKey<FormState>();
  final personaProvider = new PersonaProvider();
  String _fecha = '';

  TextEditingController _inputfieldDateController = new TextEditingController();

  PersonaModel persona = new PersonaModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persona'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearApellido(),
                _crearDireccion(),
                _crearTelefono(),
                _crearFechaNacimiento(context),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre'),
      onSaved: (value) => persona.nombre = value,
      validator: (value) {
        var result;
        value.length != 0 ? result = null : result = 'Ingrese un nombre';
        return result;
      },
    );
  }

  Widget _crearApellido() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellido'),
      onSaved: (value) => persona.apellido = value,
      validator: (value) {
        var result;
        value.length != 0 ? result = null : result = 'Ingrese un apellido';
        return result;
      },
    );
  }

  Widget _crearDireccion() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Direccion'),
      onSaved: (value) => persona.direccion = value,
      validator: (value) {
        var result;
        value.length != 0 ? result = null : result = 'Ingrese una direccion';
        return result;
      },
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Telefono'),
      onSaved: (value) => persona.telefono = value,
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Ingrese solo numeros';
        }
      },
    );
  }

  Widget _crearFechaNacimiento(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _inputfieldDateController,
      decoration: InputDecoration(labelText: 'Fecha Nacimiento'),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());

        _selectDate(context);
      },
      onSaved: (value) => persona.fechaNacimiento = value,
      validator: (value) {
        var result;
        value.length != 0 ? result = null : result = 'Ingrese una fecha de nacimiento';
        return result;
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2025));

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();

        _inputfieldDateController.text =
            DateFormat("yyyy-MM-dd").format(DateTime.parse(_fecha));
      });
    }
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print('>>>>>>>>>>');
    print(persona.nombre);
    print(persona.apellido);
    print(persona.direccion);
    print(persona.telefono);
    print(persona.fechaNacimiento);
    print(persona.estado);
    print('>>>>>>>>>>');
    print(new DateFormat("yyyy-MM-dd").format(DateTime.now()));
    personaProvider.crearPersona(persona);
  }
}
