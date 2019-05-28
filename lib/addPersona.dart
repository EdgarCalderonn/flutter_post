import 'package:flutter/material.dart';
import 'package:ejemplopost/clases.dart';


class AgregarPersona extends StatelessWidget {
  TextEditingController ctrl = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Agregar Usuario",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              child: TextField(
                controller: ctrl,
                autofocus: true,
                decoration: InputDecoration(hintText: "Nombre"),
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            RaisedButton(
              child: Text("Agregar"),
              onPressed: () async{


                await Datos.addPersona(ctrl.text).whenComplete((){

                  showDialog(context: context,child: __MensajeCargando(context));

                });


                ctrl.text="";



              },
            )
          ],
        ),
      ),
    );
  }


  __MensajeCargando(BuildContext context)
  {
    return AlertDialog(


      content: Text("Ha agregado con exito al usuario a la DB"),

      actions: <Widget>[
        FlatButton(
          child: Text("Vale",style: TextStyle(color: Colors.amberAccent),),
          onPressed: (){

            Navigator.popUntil(context, ModalRoute.withName("/"));
            Navigator.pushNamed(context, "/MostrarPersonas");



          },
        )
      ],


    );
  }





}