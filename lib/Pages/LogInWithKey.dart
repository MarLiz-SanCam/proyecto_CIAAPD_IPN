
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_app_asistencia_ipn/Colors/ColorVino.dart';
import 'package:proyecto_app_asistencia_ipn/Pages/OpenSesion.dart';
class LogInWithKey extends StatefulWidget{
  const LogInWithKey({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LogInWithKey> createState() => _LogInWithKeyState();
}

class _LogInWithKeyState extends State<LogInWithKey> {
  bool isButtonActive = false;
  String asignedKey = "A1B-2C3"; /*TODO: Esta variable va a bajar del servidor
  (El valor asignado para la prueba debe ser modificado) y se le
  va a indicar al usuario, después de va a comparar con la clave ingresada por
  el usuario y si coincide, se abre la sesión*/
  int keyLen = 7;
  String keyInput = "";
  //final formGlobalKey = GlobalKey <FormState>();
  // ----------------------- Controller ----------------------- //
  late TextEditingController keyController;
  @override
  void initState(){
    super.initState();
    keyController = TextEditingController();
    keyController.addListener(() {
      final ThereIsText = keyController.text.isNotEmpty;
      setState(() => isButtonActive = ThereIsText);
    });
  }
  @override
  void dispose(){
    keyController.dispose();
    super.dispose();
  }
  // ----------------------- FinControl ----------------------- //
  //bool isKeyValid( String validKey) => validKey.length == keyLen;
  savingKey(){
    keyInput = keyController.text;
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
        //key: formGlobalKey,
        children: [
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
                  'Ingrese clave asignada.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 100.0,
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
                          "Clave: ",
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
                        color: Colors.white,
                        height: 40.0,
                        //width: 200.0,
                        child: TextFormField(
                          cursorColor: ColorVino.vino,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          maxLength: keyLen,
                          controller: keyController,
                          //print("El usuario escribió: ");
                          //obscureText: true,
                        ),

                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Solicite su clave dinámica de acceso en la oficina correspondiente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 120.0,
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
