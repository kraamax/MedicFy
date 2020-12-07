import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatelessWidget {
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/fondo2.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 500.0,
              ),
              _buildLoginButton(context),
              SizedBox(
                height: 10.0,
              ),
              _buildSignInButton(context)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ButtonTheme(
      height: 50.0,
      minWidth: 250.0,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          storage.deleteAll();
          Navigator.pushReplacementNamed(context, 'login');
        },
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(fontSize: 22),
        ),
        shape: StadiumBorder(),
        elevation: 10.0,
        textColor: Colors.white,
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return ButtonTheme(
      height: 50.0,
      minWidth: 250.0,
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, 'addUser');
        },
        child: Text(
          'Regístrate',
          style: TextStyle(fontSize: 22),
        ),
        shape: StadiumBorder(),
        elevation: 10.0,
        textColor: Colors.blue,
      ),
    );
  }
}
