import 'package:flutter/material.dart';
import 'package:form_validate/src/bloc/provider.dart';
import 'package:form_validate/src/pages/home_page.dart';
import 'package:form_validate/src/pages/login_page.dart';
import 'package:form_validate/src/pages/persona_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'persona': (BuildContext context) => PersonaPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}
