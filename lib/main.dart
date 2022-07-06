
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_app_asistencia_ipn/Colors/ColorVino.dart';
import 'package:proyecto_app_asistencia_ipn/Pages/HomePage.dart';
// --------------------------  Fin de los 'import' -------------------------- //

// Función Main de la aplicación
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Control Asistencias",
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('Error found!! ${snapshot.error.toString()}');
            return Text('Something went wrong...');
          }else if(snapshot.hasData){
            return HomePage();
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      //HomePage(), // Página principal de la aplicación
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: ColorVino.vino,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorVino.vino),
      ),
    );
  }
}
