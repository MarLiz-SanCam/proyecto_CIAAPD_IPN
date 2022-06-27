
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_app_asistencia_ipn/Colors/ColorVino.dart';

class OpenSesion extends StatefulWidget {
  const OpenSesion( {Key? key}) : super(key: key);

  @override
  _OpenSesionState createState() => _OpenSesionState();
}

class _OpenSesionState extends State<OpenSesion> {
  int milisegundos = 0;
  late Timer timer;
  String timeActive = " "; //guarda en una cadena de texto el tiempo de actividad de la sesión en horas.
  bool isRunning = false;

  // INICIAR CRONOMETRO
  void iniciarTimer(BuildContext context){
    if(!isRunning){
      timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        this.milisegundos += 100;
        setState(() { });
      });
      isRunning = true;
    }
  }
  // DETENER CRONÓMETRO
  void detenerTimer(){
    timeActive = formatearTiempo();
    timer.cancel();
    print("TIEMPO FINAL DE SESIÓN ACTIVA: $timeActive");
    isRunning = false;
  }

  //INICIA EL CRONOMETRO EN CUANTO ENTRA A LA PÁGINA
  void initState() {
    super.initState(); WidgetsBinding.instance!.addPostFrameCallback((_) => iniciarTimer(context));
  }

  //DA TODO EL FORMATO REQUERIDO DE TIEMPO
  String formatearTiempo(){
    Duration duracion = Duration(milliseconds: this.milisegundos);
    String twoDigits(int valor){
      return valor >= 10 ? "$valor" : "0$valor";
    }
    String horas = twoDigits(duracion.inHours);
    String minutos = twoDigits(duracion.inMinutes.remainder(60));
    String segundos = twoDigits(duracion.inSeconds.remainder(60));
    //String milisegundos = twoDigits(duracion.inMilliseconds.remainder(1000));
    if(duracion.inHours >= 10){
      detenerTimer();
      print("El tiempo de actividad superó el límite permitido");
    }
    return "$horas:$minutos:$segundos";
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
        children: <Widget>[
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
                SizedBox(height: 100.0,
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
                          "Tiempo de horas activas de la sesión: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        //color: Colors.black87,
                        height: 100.0,
                        //width: 200.0,
                        child: Text(
                          //"00:00:00:00",
                          formatearTiempo(),
                          style: TextStyle(fontSize: 55, fontFamily: "RobotoSlab"),
                        ),
                      ),
                      SizedBox(
                        height: 125.0,
                      ),
                    ],
                  ),
                ),

                Container(
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          //style: style,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(ColorVino.vino),
                          ),
                          onPressed: () {
                            /* Cierra la sesión y sale de la app */
                            //print(" Botón presionado :) Confirmado");
                            detenerTimer();
                            this.milisegundos = 0;
                            setState(() {});
                            Navigator.of(context).pop();
                            SystemNavigator.pop();
                          },
                          child: const Text('Cerrar sesión',
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
