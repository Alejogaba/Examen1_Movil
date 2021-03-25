import 'package:flutter/material.dart';
import 'package:flutter_application_exam/componentes/lista.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<String> credenciales = [];

  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 27.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Inicio de sesión",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("https://cdn.pixabay.com/photo/2016/11/08/15/21/user-1808597_640.png"))),
            ),
            _InputText(
              customController: usernameController,
              labelText: "Nombre de usuario",
              isPassword: false,
            ),
            _InputText(
              customController: passwordController,
              labelText: "Contraseña",
              isPassword: true,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(color: Colors.lightGreen)))),
                  onPressed: () {
                    setState(() {
                      _Login(context, usernameController, passwordController);
                    });
                  },
                  child: Text(
                    "Iniciar sesión",
                    style: TextStyle(fontSize: 25),
                  )),
            )
          ],
        ),
      ),
    );
  }

  _Login(BuildContext context, TextEditingController controladorNombre,
      TextEditingController controladorContrasena) {
    setState(() {
      if (controladorNombre.text.isEmpty || controladorNombre.text.isEmpty) {
        cajatexto(context, "No deje campos vacios");
      } else {
        if (controladorNombre.text.contains(' ') ||
            controladorContrasena.text.contains(' ')) {
          cajatexto(context, "No ingrese espacios en blanco");
        } else {
          
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Principal(controladorNombre.text)));
        }
      }
    });
  }

  Future<dynamic> cajatexto(BuildContext context, String mensaje) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Aviso',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                '$mensaje',
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.grey),
                    ))
              ],
            ));
  }
}

class _InputText extends StatelessWidget {
  const _InputText(
      {Key key,
      @required this.customController,
      this.labelText,
      this.isPassword})
      : super(key: key);

  final TextEditingController customController;
  final String labelText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: TextField(
          style: TextStyle(fontSize: 20),
          controller: customController,
          obscureText: this.isPassword,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              filled: true,
              hintStyle: TextStyle(fontSize: 20),
              labelStyle: TextStyle(fontSize: 20),
              hintText: this.labelText,
              fillColor: Colors.white70),
          onSubmitted: (String nombre) {}),
    );
  }
}
