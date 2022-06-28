//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_app_asistencia_ipn/Colors/ColorVino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyecto_app_asistencia_ipn/Pages/LogInPresenciales.dart';
import 'package:proyecto_app_asistencia_ipn/Pages/LogInDistancia.dart';
// --------------------------  Fin de los 'import' -------------------------- //

// Página principal de la aplicación.
class HomePage extends StatelessWidget{
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
        children: <Widget>[
          Column(
            children: <Widget>[
            //Contenedor de títulos
            Container( //Contenedor de títulos
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    transformAlignment: Alignment.center,
                    child: Row( // Logos y nombre ESIME
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image( //Logo IPN config
                          image: AssetImage("images/LogoIPN_blanco.png"), //Imagen
                          height: 80.0,
                        ),
                        Container( //Contenedor del texto (nombre de la escuela [ESIME])
                          transformAlignment: Alignment.center,
                          width: 207.0,
                          child: Text(
                            "Escuela Superior de Ingeniería Mecánica y Eléctrica",
                            //Texto del contenedor (nombre de la escuela)
                            style: TextStyle( //Configuración del estilo del texto
                                fontFamily: 'RobotoSlab',
                                color: Colors.white, //Color del texto
                                fontSize: 20.0,
                              fontWeight: FontWeight.w100
                            ),
                            textAlign: TextAlign.center, //Alineación del texto
                          ),
                        ),
                        Image( //Logo ESIME config
                          image: AssetImage("images/logoesime.png"), //imagen
                          height: 58.0, //Tamaño de imagen
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    " ACADEMIA DE FÍSICA ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PTSerif',
                        fontWeight: FontWeight.w200,
                        fontSize: 15.0
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    " ICE ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    " Control Interactivo Auxiliar de Asistencias del personal Docente ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontFamily: 'PTSerif',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    " ( CAAPD )",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  )
                ],
              ),
                padding: EdgeInsets.all(15.0),
                color: ColorVino.vino
            ),
            //Caja de espaciado
            SizedBox(
              height: 140.0,
            ),
            //Contenedor del cuerpo del programa
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 45.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    child: const Text(
                      'Iniciar Sesión\nPresencial',
                      style: TextStyle(
                        color: Colors.white,
                          //fontFamily: 'PTSerif',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    color: ColorVino.vino,
                    elevation: 0,
                    height: 60.0,
                    minWidth: 170.0,
                    splashColor: Colors.transparent,
                    onPressed: () async {
                      /* Este botón no pide acceso a la ubicación
                      *  ingresa al sistema de inicio de sesión
                      * de versión en línea. */
                      Navigator.push( //Navega a la siguiente página.
                        context,
                        MaterialPageRoute(builder: (context) => LogInEnPresencial(title: "IPN")),
                      );
                    }
                ),
                  SizedBox(
                    height: 35.0,
                  ),
                  MaterialButton(
                      child: const Text(
                        'Iniciar Sesión\nA Distancia',
                        style: TextStyle(
                          color: Colors.white,
                          //fontFamily: 'PTSerif',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      color: ColorVino.vino,
                      elevation: 0,
                      height: 60.0,
                      minWidth: 170.0,
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        /* Cuando el botón se presiona porprimera vez,
                       * muestra por pantalla la alerta que pide permiso para
                       * acceder a la ubicación (sig línea de código) [...] */
                        final status = await Permission.location.request();
                        if(status == PermissionStatus.granted){
                          /* [...] Si el permiso se concede, navegará  a la
                         * pantalla de inicio de sesión, permitiendo al
                         * usuario ingresar sus datos */
                          Navigator.push( //Navega a la siguiente página.
                            context,
                            MaterialPageRoute(builder: (context) => LogInADistancia(title: 'IPN',)),
                          );
                        }else{
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) =>AlertDialog(
                              title: const Text('Se requiere el acceso a la ubicación'),
                              content: Text('Para continuar con el inicio de sesión, la aplicación requiere acceso a la ubicación del dispositivo, cambie la configuración correspondiente.'),
                              actions: <Widget>[
                                TextButton(
                                  /* si se selecciona este botón, enviará a las configuraciones
                                 * del dispositivo para que el usuario dé el accesso a la
                                 * ubicación de forma manual */
                                    child: const Text('Aceptar'),
                                    onPressed: (){
                                      openAppSettings();
                                    }
                                ),
                                TextButton(
                                  //Si se selecciona este botón, la aplicación se cerrará
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    SystemNavigator.pop();
                                  },
                                ),
                              ],
                            ),
                          );
                          /*
                         Enviar Alerta de que no se pudo Acceder a la
                         ubicación, si en la alerta, se acepta el
                         uso de la ubicación, enviará al ususario a la config
                         para que permita el acceso a la ubicación manualmente
                         */
                        }
                      }
                  ),
                ],
              ),
             ),
            ],
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
