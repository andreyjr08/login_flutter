import 'package:flutter/material.dart';
import 'package:form_validate/src/bloc/provider.dart';
import 'package:form_validate/src/models/PersonaModel.dart';
import 'package:form_validate/src/providers/persona_provider.dart';

class HomePage extends StatelessWidget {
  final personaProvider = new PersonaProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: personaProvider.listarPersonas(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PersonaModel>> snapshot) {
          if (snapshot.hasData) {
            final personas = snapshot.data;
            return ListView.builder(
              itemCount: personas.length,
              itemBuilder: (context, i) => _crearItem(context, personas[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, PersonaModel persona) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direccion ){
        personaProvider.inactivarPersona(persona.id);
      },
      child: ListTile(
        title: Text('${persona.nombre} ${persona.apellido}'),
        subtitle: Text(persona.estado),
        onTap: () =>
            Navigator.pushNamed(context, 'persona', arguments: persona),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'persona'),
    );
  }
}
