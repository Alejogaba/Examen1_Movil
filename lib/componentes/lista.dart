import 'package:flutter/material.dart';
import 'package:flutter_application_exam/componentes/agregarModificar.dart';
import 'package:flutter_application_exam/entities/Cliente.dart';

class Principal extends StatefulWidget {
  String username;

  Principal(this.username, {Key key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState(this.username);
}

class _PrincipalState extends State<Principal> {
  String username;
  List<Cliente> _clientes = [];

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  _PrincipalState(this.username);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de clientes',
       theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),  
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de clientes'),
          actions: [
            Center(
                child: Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Text(
                username,
                style: TextStyle(fontSize: 21),
              ),
            ))
          ],
        ),
        body: ListView.builder(
            itemCount: _clientes.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => agregarModificar(
                              nombre: _clientes[index].nombre,
                              apellido: _clientes[index].apellido,
                              profesion: _clientes[index].profesion,
                              fechaNacimiento: _clientes[index].fechaNacimiento,
                              index: index,
                              urlImagen: _clientes[index].urlImagen,))).then((resultado) {
                    if (resultado != null) {
                      Cliente cliente = resultado;
                      _clientes[cliente.index] = cliente;
                      print(
                          "Cliente ${_clientes[cliente.index].nombre} modificado correctamente");
                      setState(() {});
                    } else {
                      print('No se incluyo ningún dato');
                    }
                  });
                },
                onLongPress: () {
                  setState(() {
                    _eliminarcliente(context, _clientes[index]);
                  });
                },
                title: Row(
                  children: [Text(_clientes[index].nombre +
                    ' ' +
                    _clientes[index].apellido),
                    Spacer(),
                    Text('Fecha de nacimiento: '+_clientes[index].fechaNacimiento.toLocal().toString().split(' ')[0],
                    textAlign: TextAlign.right,)
                    ],),
                subtitle: Row(
                  children:[
                    Text(_clientes[index].profesion),
                    Spacer(),
                    Text('Edad: '+calcularEdad(_clientes[index].fechaNacimiento).toString(),
                    textAlign: TextAlign.right,),
                  ]
                ),
                
                leading: CircleAvatar(
                  child: (_clientes[index].urlImagen==null)?Text(
                      _clientes[index].nombre.toUpperCase().substring(0, 1)):null,
                  backgroundImage: (_clientes[index].urlImagen!=null)?NetworkImage(_clientes[index].urlImagen):null,
                ),
              
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                    context, MaterialPageRoute(builder: (_) => agregarModificar()))
                .then((resultado) {
              if (resultado != null) {
                _clientes.add(resultado);
                print(
                    "Cliente ${_clientes[_clientes.length - 1].nombre} añadido correctamente");
                setState(() {});
              } else {
                print('No se incluyo ningún dato');
              }
            });
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  calcularEdad(DateTime fechaNacimiento) {
    DateTime fechaActual = DateTime.now();
    int age = fechaActual.year - fechaNacimiento.year;
    int month1 = fechaActual.month;
    int month2 = fechaNacimiento.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = fechaActual.day;
      int day2 = fechaNacimiento.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  _eliminarcliente(context, Cliente client) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Eliminar cliente'),
              content: Text('¿Desea eliminar a ' + client.nombre + ' '+client.apellido+'?'),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _clientes.remove(client);
                        Navigator.of(context, rootNavigator: true).pop('dialog');  
                      });
                    },
                    child: Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.blueGrey),
                    ))
              ],
            ));
  }
}


