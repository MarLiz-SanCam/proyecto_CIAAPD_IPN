
//import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_app_asistencia_ipn/Colors/ColorVino.dart';
import 'package:proyecto_app_asistencia_ipn/Pages/LogInWithKey.dart';
import 'package:proyecto_app_asistencia_ipn/Pages/OpenSesion.dart';

class LogInPage extends StatefulWidget{
  const LogInPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LogInPage> createState() => _LogInPageState();
}


class _LogInPageState extends State<LogInPage> {
  File? credencial; //Archivo de la imagen de la credencial tomada o seleccionada
  File? location;
  bool isButtonActive = false;
  bool ThereIsCred = false;
  bool ThereIsLocation = false;
  // ------------------- Función para seleccionar la imagen de la galería
  Future selectFromGallery() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null ) return;
      final imageTemp = File(image.path);
      setState(() {
        this.credencial = imageTemp;
        this.ThereIsCred = true;
      });
    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }
  // ------------------- Función para Tomar foto de la credencial
  Future picWithCamera() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null ) return;
      final imageTemp = File(image.path);
      setState(() {
        this.credencial = imageTemp;
        this.ThereIsCred = true;
      });
    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }
  // ------------------- Función para Tomar foto de la ubicación
  Future picGeolocation() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null ) return;
      final imageTemp = File(image.path);
      setState(() {
        this.location = imageTemp;
        this.ThereIsLocation = true;
      });
    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }
  // ----------------------- Controller ----------------------- //
  late TextEditingController controller;
  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      final ThereIsText = controller.text.isNotEmpty;
      print("there is text == $ThereIsText");
      print("there is cred == $ThereIsCred");
      print("there is locat == $ThereIsLocation");
      setState(() {
        if(ThereIsCred == true && ThereIsLocation == true && ThereIsText == true){
          this.isButtonActive = true;
        }else{
          print("Falta llenar algún campo");
        }
      });
    });
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  // ----------------------- FinControll ----------------------- //
  int milisegundos = 0;
  late Timer timer;
  late String timeActive; //guarda en una cadena de texto el tiempo de actividad de la sesión en horas.
  bool isRunning = false;
  void iniciarTimer(){
    if(!isRunning){
      timer = Timer.periodic(Duration(microseconds: 100), (timer) {
        this.milisegundos += 100;
        setState(() { });
      });
      isRunning = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    /*Color getColor(Set<MaterialState> states) { // Función para el color de las checkbox
      return Colors.white;
    }*/
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( //Barra de la aplicación
        centerTitle: true, //Centra el título de la barra de la aplicación
        title: Text(
          'I P N',
          //Texto para el título de la aplicación (aparece en la barra)
          style: TextStyle(
              fontSize: 25.0,
              fontFamily: "RobotoSlab",
          ),
        ),
        backgroundColor: ColorVino.vino,
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 40),
            //color: Colors.yellow,
            child: Column(
              children: [
                Image(
                  image: AssetImage(
                      "images/LogoIPN_vino.png"
                  ),
                  height: 125.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  'Ingrese sus datos de inicio de sesión.',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                ),
                Container(
                  //color: ColorVino.vino,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Imagen de la credencial. ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(ColorVino.vino),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  //barrierDismissible: false,
                                  builder: (context) =>AlertDialog(
                                    // Abrir la cámara o la galería
                                    title: const Text('Tomar fotografía o seleccionar imagen.'),
                                    content: Text('Selecciona una opción.'),
                                    actions: <Widget>[
                                      TextButton(
                                        /* si se selecciona este botón, enviará a las configuraciones
                                 * del dispositivo para que el usuario dé el accesso a la
                                 * ubicación de forma manual */
                                          child: const Text('Tomar Fotografía con la cámara'),
                                          onPressed: (){
                                            picWithCamera();
                                            //llama a la función de tomar foto
                                            Navigator.pop(context);
                                          }
                                      ),
                                      TextButton(
                                        //Si se selecciona este botón, la aplicación se cerrará
                                        child: const Text('Seleccionar imagen de la galería'),
                                        onPressed: () {
                                          selectFromGallery();
                                          Navigator.pop(context);//llama a la función de seleccionar de la galería
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text('Tomar foto ó seleccionar archivo'),
                            ),
                            credencial == null ? Text("Falta tomar/seleccionar imagen") : Text("Imagen cargada"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Evidencia de ubicación. ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(ColorVino.vino),
                              ),
                              onPressed: () {
                                // Abrir la cámara ¡NO LA GALERÏA!
                                picGeolocation();
                              },
                              child: const Text('Tomar foto a la ubicación actual'),
                            ),
                            location != null ? Text("Imagen cargada") : Text("Falta tomar fotografía")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Nombre Completo. ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.black12,
                        height: 35.0,
                        //width: 200.0,
                        child: TextFormField(
                          /*decoration: InputDecoration(
                        label: Text("Nombre"),
                      ),*/
                          controller: controller,
                          cursorColor: ColorVino.vino,
                        ),
                      ),
                      Container(
                        //transformAlignment: Alignment.topRight,
                        child: TextButton(
                            child: const Text(
                              "ó inicie sesión con clave proporcionada",
                              textAlign: TextAlign.right,
                            ),
                            style: TextButton.styleFrom(

                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: (){
                              Navigator.push( //Navega a la siguiente página.
                                context,
                                MaterialPageRoute(builder: (context) => LogInWithKey(title: 'IPN',)),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(ColorVino.vino),
                        ),
                        onPressed: () {
                          print(" Botón presionado :O Inicio de sesión cancelado");
                          Navigator.of(context).pop();
                          SystemNavigator.pop();
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        /* Este botón estará activo si y sólo sí, las dos imágenes
                         * y el campo del nombre están completos (y el nombre coincide con la base de datos)*/
                        style: ElevatedButton.styleFrom(
                          primary: ColorVino.vino,
                          onSurface: ColorVino.vino[500],
                        ),
                        onPressed: isButtonActive
                            ? () {
                          print(" Botón presionado:)  se inicia sesión...");
                          Navigator.push( //Navega a la siguiente página.
                            context,
                            MaterialPageRoute(builder: (context) => OpenSesion())
                          );
                        }
                            : null,
                        //onPressed: null,
                        child: const Text('Confirmar',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //void setState(File Function() param0) {}
}