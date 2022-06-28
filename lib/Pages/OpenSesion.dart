
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
          SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black12,
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
                SizedBox(height: 5.0,
                ),
                Container(
                  child: Text("Instituto Politécnico Nacional",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorVino.vino,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0,
                ),

                SizedBox(height: 100.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    width: 135,
                    child: ElevatedButton(
                      //style: style,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(ColorVino.vino),
                        //maximumSize: Size(10.0,400.0)
                        //minimumSize: Size(10.0, 100.0.),
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
                      child: const Text('Descargar',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      //style: style,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(ColorVino.vino),
                      ),
                      onPressed: () {
                        //Agregar confirmación de cierre de sesión. AlertDialog
                        /* Cierra la sesión y sale de la app */
                        //print(" Botón presionado :) Confirmado");
                        detenerTimer();
                        this.milisegundos = 0;
                        setState(() {});
                        Navigator.of(context).pop();
                        SystemNavigator.pop();
                      },
                      child: const Text('Salir',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    width: 135,
                    height: 40,
                  )
                ],
              )
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
