import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicfy/src/models/user.dart';
import 'package:medicfy/src/services/application_user_service.dart';
import 'package:medicfy/utils/my_flutter_app_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User user = new User(
      email: '', name: '', bornDate: '', password: '', sex: 'Masculino');
  String _bornDate = '';
  var _inputFieldBornDateController = new TextEditingController();
  String _selectedOptionSex = 'Masculino';
  List sexs = ['Masculino', 'Femenino'];
  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.account_circle),
              SizedBox(
                width: 10.0,
              ),
              Text('Registrate'),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 30.0),
          children: [
            Form(key: _formKey, child: Column(children: _buildFormFields())),
            SizedBox(
              height: 40.0,
            ),
            _buildButtonSave()
          ],
        ),
      ),
      inAsyncCall: _isInAsyncCall,
    );
  }

  List<Widget> _buildFormFields() {
    final widgets = [
      _buildNameField(),
      SizedBox(
        height: 15.0,
      ),
      _buildEmailField(),
      SizedBox(
        height: 15.0,
      ),
      _buildBornDateField(context),
      SizedBox(
        height: 15.0,
      ),
      _buildSexDropDown(),
      SizedBox(
        height: 15.0,
      ),
      _buildPasswordField(),
    ];
    return widgets;
  }

  Widget _buildButtonSave() {
    return Center(
      child: ButtonTheme(
        minWidth: 200.0,
        height: 50.0,
        child: FlatButton(
          color: Colors.blue,
          onPressed: _formKey.currentState != null
              ? validateFields()
                  ? _saveData
                  : null
              : null,
          child: Text(
            'Guardar',
            style: TextStyle(fontSize: 16),
          ),
          shape: StadiumBorder(),
          textColor: Colors.white,
          disabledColor: Colors.blue[300],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return "Nombre requerido";
        }
      },
      onSaved: (valor) {
        setState(() {
          user.name = valor;
        });
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Nombre',
          labelText: 'Nombre',
          //Icono derecha
          suffixIcon: Icon(Icons.account_circle),
          icon: Icon(Icons.account_circle_rounded)),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return "Email requerido";
        }
      },
      onSaved: (valor) {
        setState(() {
          user.email = valor;
        });
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Email',
          labelText: 'Email',
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(Icons.email)),
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
          user.password = valor;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock),
      ),
    );
  }

  Widget _buildBornDateField(BuildContext context) {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return "Contraseña requerida";
        }
      },
      onSaved: (valor) {
        setState(() {
          user.bornDate = valor;
        });
      },
      controller: _inputFieldBornDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          //Icono derecha
          suffixIcon: Icon(Icons.perm_contact_calendar),
          icon: Icon(Icons.calendar_today)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2040),
        locale: Locale('es', 'ES'));
    if (picked != null) {
      setState(() {
        _bornDate = picked.toLocal().toString().split(' ')[0];
        user.bornDate = _bornDate;
        _inputFieldBornDateController.text = _bornDate;
      });
    }
  }

  List<DropdownMenuItem<String>> getDataFromStringDropdown(List list) {
    List<DropdownMenuItem<String>> lista = new List();

    list.forEach((op) {
      lista.add(DropdownMenuItem(
        child: Text(op),
        value: op,
      ));
    });
    return lista;
  }

  Widget _buildSexDropDown() {
    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(width: 30),
        Expanded(
          child: DropdownButton(
              value: _selectedOptionSex,
              items: getDataFromStringDropdown(sexs),
              onChanged: (opt) {
                setState(() {
                  print(opt);
                  _selectedOptionSex = opt;
                  user.sex = opt;
                });
              }),
        ),
      ],
    );
  }

  bool validateFields() {
    if (_formKey.currentState.validate()) return true;
    return false;
  }

  void _saveData() {
    setState(() {
      _isInAsyncCall = true;
    });
    if (!_formKey.currentState.validate()) {
      return;
    }
    user.sex = _selectedOptionSex;
    _formKey.currentState.save();
    ApplicationUserService.postUser(user).then((value) {
      if (value) {
        showSuccesfullToast('Se ha registrado correctamente');
        setState(() => _isInAsyncCall = false);
        Navigator.pop(context);
      } else {
        setState(() => _isInAsyncCall = false);
        showToast('No se pudo agregar');
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

  void showSuccesfullToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
