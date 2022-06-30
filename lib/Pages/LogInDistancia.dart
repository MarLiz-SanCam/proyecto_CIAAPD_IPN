
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_app_asistencia_ipn/Colors/ColorVino.dart';
import 'package:proyecto_app_asistencia_ipn/Pages/OpenSesion.dart';
class LogInADistancia extends StatefulWidget{
  const LogInADistancia({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LogInADistancia> createState() => _LogInADistanciaState();
}

class _LogInADistanciaState extends State<LogInADistancia> {
  File? credencial; //Archivo de la imagen de la credencial tomada o seleccionada
  bool ThereIsCred = false;
  bool isButtonActive = false;
  String asignedKey = "SACM010710"; /*TODO: Esta variable va a bajar del servidor
  (El valor asignado para la prueba debe ser modificado) y se le
  va a indicar al usuario, después de va a comparar con la clave ingresada por
  el usuario y si coincide, se abre la sesión*/
  int keyLen = 10;
  String keyInput = "";
  //final formGlobalKey = GlobalKey <FormState>();
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
  // ----------------------- Controller ----------------------- //
  late TextEditingController UserController;
  @override
  void initState(){
    super.initState();
    UserController = TextEditingController();
    UserController.addListener(() {
      final ThereIsText = UserController.text.isNotEmpty;
      setState(() => isButtonActive = ThereIsText);
    });
  }
  @override
  void dispose(){
    UserController.dispose();
    super.dispose();
  }
  // ----------------------- FinControl ----------------------- //
  //bool isKeyValid( String validKey) => validKey.length == keyLen;
  savingKey(){
    keyInput = UserController.text;
    print(" La clave ingresada es: $keyInput");
  }
  failedKeyMessage() {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Clave incorrecta"),
            content: Text("La clave ingresada es incorrecta, intente de nuevo."),
            actions: <Widget>[
              TextButton(
                //Si se selecciona este botón, la aplicación se cerrará
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black12,
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
           SizedBox(
             height: 15,
           ),
           Container(
             alignment: Alignment.center,
             padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 40),
             //color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  height: 70.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Usuario. ",
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
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.black12,
                  height: 35.0,
                  //width: 200.0,
                  child: TextFormField(
                    controller: UserController,
                    cursorColor: ColorVino.vino,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child:
                    Text("Código de usuario"),
                ),
                SizedBox(
                  height: 50.0,
                ),
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
                  alignment: Alignment.center,
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
                      SizedBox(
                        height: 5,
                      ),
                      credencial == null ? Text("Falta tomar/seleccionar imagen") : Text("Imagen cargada"),
                    ],
                  ),
                ),

              ],
            ),
          ),
           SizedBox(
             height: 90,
           ),
           Container(
               padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
               child:
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   ElevatedButton(
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all<Color>(ColorVino.vino),
                     ),
                     onPressed: () {
                       //print(" ¿dónde está este botón? xd");
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
                     //style: style,
                     style: ElevatedButton.styleFrom(
                       primary: ColorVino.vino,
                       onSurface: ColorVino.vino[500],
                     ),
                     onPressed: isButtonActive
                         ? () {
                       savingKey();
                       if(keyInput == asignedKey){
                         print(" Botón presionado:)  se inicia sesión...");
                         Navigator.push( //Navega a la siguiente página.
                           context,
                           MaterialPageRoute(builder: (context) => OpenSesion()),
                         );
                       }else failedKeyMessage();

                     }
                         : null,
                     //onPressed: null,
                     child: const Text('Verificar',
                       style: TextStyle(
                         fontSize: 18.0,
                       ),
                     ),
                   ),
                 ],
               )
           ),
        ],
      ),
    );
  }
}

/*mixin InputValidationMixin{
  int keyLen = 10;
  bool isKeyValid( String validKey) => validKey.length == keyLen;
}*/
