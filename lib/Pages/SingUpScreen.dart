
//import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_app_asistencia_ipn/Colors/ColorVino.dart';

// --------------------------  Fin de los 'import' -------------------------- //


class SignUpScreen extends StatefulWidget{
  const SignUpScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}
class _SignUpScreen extends State<SignUpScreen>{
  //VARIABLES
  File? credencial; //Archivo de la imagen de la credencial tomada o seleccionada
  bool ThereIsCred = false;
  // fin variables
  // FUNCIONES //
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
  //Fin Funciones

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( //Barra de la aplicación
        centerTitle: true, //Centra el título de la barra de la aplicación
        title: Text(
          'Instituto Politécnico Nacional',
          //Texto para el título de la aplicación (aparece en la barra)
          style: TextStyle(
              fontSize: 22.0,
              fontFamily: 'RobotoSlab'
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
                  'Generar Usuario.',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                ),
                Text('Ingrese a continuación sus datos en los campos correspondientes',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Roboto',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,),),
                SizedBox(
                  height: 40.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Nombre(s). ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                      TextFormField( //Todo validador del nombre
                        cursorColor: ColorVino.vino,
                        decoration: const InputDecoration(
                          labelText: 'Nombre (s)',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Ingrese el dato solicitado!';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Apellidos",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                      TextFormField( //Todo: Agregar TextEditingController
                        cursorColor: ColorVino.vino,
                        decoration: const InputDecoration(
                          labelText: 'Apellido Paterno',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Ingrese el dato solicitado!';
                          }
                        },
                      ),
                      TextFormField( //Todo: Agregar TextEditingController
                        cursorColor: ColorVino.vino,
                        decoration: const InputDecoration(
                          labelText: 'Apellido Materno',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Ingrese el dato solicitado!';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "CURP ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                      TextFormField( //Todo: Agregar TextEditingController
                        cursorColor: ColorVino.vino,
                        decoration: const InputDecoration(
                          labelText: 'CURP',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Ingrese el dato solicitado!';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "RFC ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                      TextFormField( //Todo: Agregar TextEditingController
                        cursorColor: ColorVino.vino,
                        decoration: const InputDecoration(
                          labelText: 'RFC',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Ingrese el dato solicitado!';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Correo Electrónico",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                      TextFormField( /*Todo validar que los campos de correo tengan lo mismo*/
                        cursorColor: ColorVino.vino,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Ingrese el dato solicitado!';
                          }
                        },
                      ),
                      TextFormField( //Todo: Agregar TextEditingController
                        cursorColor: ColorVino.vino,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar Correo electrónico',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Ingrese el dato solicitado!';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Número de Empleado",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                      TextFormField( //Todo: Agregar TextEditingController
                        cursorColor: ColorVino.vino,
                        decoration: const InputDecoration(
                          labelText: 'No. Empleado',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Ingrese el dato solicitado!';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Escuela ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                      //Todo: Agregar seleccionador de escuela
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Escuela ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.0,
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
                          //Si se cancela el inicio de sesión, se cierra la aplicación
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
                      SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        //style: style,
                        style: ElevatedButton.styleFrom(
                          primary: ColorVino.vino,
                          onSurface: ColorVino.vino[500],
                        ),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Procesando datos')
                                )
                            );
                          }
                        },
                        //onPressed: null,
                        child: const Text('Verificar',
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
      bottomNavigationBar: BottomAppBar( //Barra del fodo de la app
        child: Text(
          'Author: MarLiz Santini',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorVino.vino[50],
          ),
        ),
        color: ColorVino.vino,
      ),
    );
  }
}