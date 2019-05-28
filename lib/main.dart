import 'package:flutter/material.dart';
import 'package:ejemplopost/clases.dart';
import 'package:ejemplopost/addPersona.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (BuildContext context) => Inicio(),
      "/MostrarPersonas": (BuildContext context) => MostrarPersonas()
    },));



class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20)

          ),
          child: FlatButton(
            child: Text("Mostrar Personas"),
            onPressed: (){
              Navigator.pushNamed(context, "/MostrarPersonas");
            },

          )
        )
      ),
    );
  }
}



class MostrarPersonas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PersonasState();
  }
}

class PersonasState extends State<MostrarPersonas> {
  var ctrl1 = new TextEditingController();
  int indexUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Personas",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AgregarPersona()));
            },
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: Datos.getPersonas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>( Colors.white ),

                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(
                          "${Datos.personas[index].nombre}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black45,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      indexUpdate = index;

                                      showDialog(
                                          context: context,
                                          child: __DialogCambiar());
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Datos.deletePersona(
                                          Datos.personas[index].id);
                                      Datos.personas.removeAt(index);
                                    });
                                  }),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  __DialogCambiar() {
    ctrl1.text = Datos.personas[indexUpdate].nombre;

    return AlertDialog(
      title: Text("Editar"),
      content: TextField(
        controller: ctrl1,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(hintText: "Nueva pregunta"),
        onSubmitted: (a) {
          setState(() {
            Datos.updatePersona(Datos.personas[indexUpdate].id, a);
            Datos.personas[indexUpdate].nombre = a;
            ctrl1.text = "";
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}
