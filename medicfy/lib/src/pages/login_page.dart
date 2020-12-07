import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:medicfy/src/models/login_model.dart';
import 'package:medicfy/src/services/application_user_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Response response = new Response('', 0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginModel loginModel = new LoginModel(userName: '', password: '');
  bool _isInAsyncCall = false;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storage.containsKey(key: 'jwt').then((value) => {
          if (value == true)
            {
              storage.read(key: 'jwt').then((token) {
                //verify token
                Navigator.pushReplacementNamed(context, 'tabPage');
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
        body: Stack(children: [
          /*Image.asset(
            "assets/f1.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),*/
          Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: _buildForm()),
        ]),
      ),
      inAsyncCall: _isInAsyncCall,
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Image.asset(
              "assets/logoMedic.png",
              height: 200.0,
              width: 200.0,
            ),
          ),
          _buildEmailField(),
          SizedBox(
            height: 20.0,
          ),
          _buildPasswordField(),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: _formKey.currentState != null
                ? validateFields()
                    ? _login
                    : null
                : null,
            child: Text(
              'Iniciar Sesión',
              style: TextStyle(fontSize: 20),
            ),
            disabledColor: Colors.blue[400],
            disabledTextColor: Colors.white,
            shape: StadiumBorder(),
            height: 50.0,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  bool validateFields() {
    if (_formKey.currentState.validate()) return true;
    return false;
  }

  void _login() {
    setState(() {
      _isInAsyncCall = true;
    });
    ApplicationUserService.login(loginModel).then((value) {
      if (value.statusCode == 200) {
        _isInAsyncCall = false;
        Navigator.pushReplacementNamed(context, 'tabPage');
      } else {
        setState(() {
          _isInAsyncCall = false;
        });
        showToast('Usuario o contraseña incorrecto');
      }
    });
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return "Email requerido";
        }
      },
      onChanged: (valor) {
        setState(() {
          loginModel.userName = valor;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        hintText: 'Email',
        fillColor: Colors.white,
        filled: true,
        suffixIcon: Icon(Icons.alternate_email),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return "Contraseña requerida";
        }
        return value.length < 4 ? 'Debe tener mas de 4 caracteres' : null;
      },
      onChanged: (valor) {
        setState(() {
          loginModel.password = valor;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        hintText: 'Contraseña',
        fillColor: Colors.white,
        filled: true,
        suffixIcon: Icon(Icons.lock_open),
      ),
    );
  }
}
