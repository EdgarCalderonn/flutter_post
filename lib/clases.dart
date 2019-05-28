import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class Persona
{
  int id;
  String nombre;

  Persona([this.id, this.nombre]);
}


class Datos
{
  static List<Persona> personas = new List<Persona>();


  static Future<List<Persona>> getPersonas() async {
    var Personas = new List<Persona>();

    var dataPersonas = await http
        .post("http://ejemplo.edgar-calderon.com/personas.php",body: jsonEncode({"password" : "contra123"}));

    print(dataPersonas.body);

    var datosPersonas = jsonDecode(dataPersonas.body);

    for (var x in datosPersonas) {
      Personas.add(new Persona(x["id"], x["nombre"]));
    }

    personas = Personas;

    for (var x in personas) {
      print("${x.id}. ${x.nombre}");
    }

    print("Se han cargado ${personas.length} personas.");


    return personas;
  }



  static Future<void> addPersona(String nombre) async {
    var data = await http.post(
        "http://ejemplo.edgar-calderon.com/addPersona.php",
        body: json.encode({"nombre": "$nombre"}));

    print(data.body);


  }


  static Future<void> updatePersona(int id, String nombre) async {
    var data = await http.post(
        "http://ejemplo.edgar-calderon.com/updatePersona.php",
        body: json.encode({"id": id, "nombre": "${nombre}"}));
    print(data.body);
  }


  static Future<void> deletePersona(int id) async {
    var data = await http.post(
        "http://ejemplo.edgar-calderon.com/deletePersona.php",
        body: json.encode({"id": id}));
    print(data.body);
  }






}