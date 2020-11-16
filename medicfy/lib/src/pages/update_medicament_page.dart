import 'package:flutter/material.dart';
import 'package:medicfy/src/models/duration.dart';
import 'package:medicfy/src/models/frequency.dart';
import 'package:medicfy/src/models/medicament.dart';
import 'package:medicfy/src/services/medicament.service.dart';
import 'package:medicfy/utils/my_flutter_app_icons.dart';

class UpdateMedicamentPage extends StatefulWidget {
  @override
  _UpdateMedicamentPageState createState() => _UpdateMedicamentPageState();
}

class _UpdateMedicamentPageState extends State<UpdateMedicamentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Medicament medicament = new Medicament(
      medicamentId: 0,
      duration: new Duration(
          durationId: 0, finalDate: '', initialDate: '', haveFinalDate: false),
      frequency:
          new Frequency(daysNumber: 0, frequencyId: 0, type: 'Diariamente'),
      medicamentName: '',
      schedule: '',
      units: '');

  String _selectedOptionFrequency = 'Diariamente';
  String _selectedOptionUnit = 'Pastilla';
  String _split = ';';
  int currentStep = 0;
  List frecuencies = [
    'Diariamente',
    'Cada x Dias',
    'Dias Especificos de la semana'
  ];
  int noUpdate = 0;
  List units = ['Pastilla', 'Capsula', 'inyeccion', 'gotas'];
  String schedule = '';
  List schedules = [];
  var _fieldInitialDateController = new TextEditingController();
  var _fieldFinalDateController = new TextEditingController();
  var _fieldNameController = new TextEditingController();
  var _fieldNoDays = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    noUpdate++;
    if (noUpdate == 1) {
      final Map arguments = ModalRoute.of(context).settings.arguments as Map;
      print('hola');
      print(arguments);
      medicament = Medicament.fromObject(arguments);
      print(medicament.medicamentName);
      schedule = medicament.schedule;
      _fieldNameController.text = medicament.medicamentName;
      _selectedOptionFrequency = medicament.frequency.type;
      _selectedOptionUnit = medicament.units;
      _fieldFinalDateController.text = medicament.duration.finalDate;
      _fieldInitialDateController.text = medicament.duration.initialDate;
      if (medicament.frequency.type == 'Cada x Dias') {
        _fieldNoDays.text = medicament.frequency.daysNumber.toString();
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Editar medicamento'),
            SizedBox(
              width: 8.0,
            ),
            Icon(Icons.edit)
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(children: [
        Form(
          key: _formKey,
          child: Stepper(
            physics: ClampingScrollPhysics(),
            steps: _createSteps(),
            type: StepperType.vertical,
            currentStep: currentStep,
            onStepTapped: (step) {
              setState(() {
                print(step);
                this.currentStep = step;
              });
            },
            onStepContinue:
                currentStep == _createSteps().length - 1 ? null : _nextStep,
            onStepCancel: currentStep == 0 ? null : _backStep,
          ),
        ),
        Center(
          child: FlatButton(
            color: Colors.blue,
            onPressed: _formKey.currentState != null
                ? validateFields()
                    ? _saveData
                    : null
                : null,
            child: Text('Guardar'),
            shape: StadiumBorder(),
            textColor: Colors.white,
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarAlerta(context),
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _nextStep() {
    setState(() {
      if (this.currentStep < this._createSteps().length - 1) {
        this.currentStep = this.currentStep + 1;
      }
    });
  }

  void _backStep() {
    setState(() {
      if (this.currentStep > 0) {
        this.currentStep = this.currentStep - 1;
      } else {
        //check if is complete
      }
    });
  }

  bool validateFields() {
    if (_formKey.currentState.validate() && schedule != '') return true;
    return false;
  }

  Widget _buildNameField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return "Nombre requerido";
        }
      },
      controller: _fieldNameController,
      onSaved: (valor) {
        setState(() {
          medicament.medicamentName = valor;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Nombre del medicamento',
        labelText: 'Nombre',
        //Icono derecha
        suffixIcon: Icon(MyFlutterApp.pill),
      ),
    );
  }

  List<Step> _createSteps() {
    List<Step> steps = [
      Step(
          title: Text('Medicamento'),
          content: _step1Content(),
          isActive: currentStep >= 0),
      Step(
          title: Text('Fecuencia'),
          content: _step2Content(),
          isActive: currentStep >= 1),
      Step(
          title: Text('Duración'),
          content: _step3Content(),
          isActive: currentStep >= 2),
      Step(
          title: Text('Hora de aplicación'),
          content: _step4Content(),
          isActive: currentStep >= 3),
    ];
    return steps;
  }

  void _saveData() {
    if (!_formKey.currentState.validate() || schedule == '') {
      return;
    }
    _formKey.currentState.save();
    print(medicament.medicamentName);
    print(medicament.frequency);
    medicament.schedule = schedule;
    medicament.duration.initialDate = _fieldInitialDateController.text;
    medicament.duration.finalDate = _fieldFinalDateController.text;
    medicament.medicamentName = _fieldNameController.text;
    if (medicament.frequency.type == 'Cada x Dias') {
      medicament.frequency.daysNumber = int.parse(_fieldNoDays.text);
    }
    MedicamentService.puttMedicament(medicament);
    Navigator.of(context).pop(true);
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

  Widget _buildFrequencyDropDown() {
    setState(() {
      medicament.frequency.type = _selectedOptionFrequency;
    });
    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(width: 30),
        Expanded(
          child: DropdownButton(
              value: _selectedOptionFrequency,
              items: getDataFromStringDropdown(frecuencies),
              onChanged: (opt) {
                setState(() {
                  _selectedOptionFrequency = opt;
                  medicament.frequency.type = opt;
                });
              }),
        ),
      ],
    );
  }

  Widget _buildXDaysField() {
    return Container(
      padding: EdgeInsets.all(5),
      width: 100.0,
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _fieldNoDays,
        validator: (String value) {
          if (value.isEmpty) {
            return "campo requerido";
          }
        },
        onSaved: (valor) {
          setState(() {
            medicament.medicamentName = valor;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'No. Dias',
          labelText: 'No. Dias',
        ),
      ),
    );
  }

  Widget _step2Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFrequencyDropDown(),
        _selectedOptionFrequency == 'Cada x Dias'
            ? _buildXDaysField()
            : SizedBox(),
      ],
    );
  }

  Widget _step1Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNameField(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _buildUnitsDropDown(),
        ),
      ],
    );
  }

  Widget _buildUnitsDropDown() {
    setState(() {
      medicament.units = _selectedOptionUnit;
    });
    return Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          child: DropdownButton(
              value: _selectedOptionUnit,
              items: getDataFromStringDropdown(units),
              onChanged: (opt) {
                setState(() {
                  _selectedOptionUnit = opt;
                  medicament.units = opt;
                });
              }),
        ),
      ],
    );
  }

  _step3Content() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: _buildInitialDateField(context),
        ),
        checkboxHaveFinalDate(),
        medicament.duration.haveFinalDate == true
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: _buildFinalDateField(context))
            : SizedBox()
      ],
    );
  }

  Widget _buildInitialDateField(BuildContext context) {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return "campo requerido";
        }
      },
      controller: _fieldInitialDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Fecha de inicio',
        labelText: 'Fecha de inicio',
        //Icono derecha
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context, 'initial');
      },
    );
  }

  Widget _buildFinalDateField(BuildContext context) {
    return TextField(
      controller: _fieldFinalDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Fecha final',
        labelText: 'Fecha final',
        //Icono derecha
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context, 'final');
      },
    );
  }

  _selectDate(BuildContext context, String caller) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2040),
        locale: Locale('es', 'ES'));
    if (picked != null) {
      setState(() {
        if (caller == 'initial') {
          _fieldInitialDateController.text =
              picked.toLocal().toString().split(' ')[0];
        } else {
          _fieldFinalDateController.text =
              picked.toLocal().toString().split(' ')[0];
        }
      });
    }
  }

  _selectHours(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    if (picked != null) {
      setState(() {
        schedule == ''
            ? schedule = picked.format(context).toString()
            : schedule =
                schedule + _split + '${picked.format(context).toString()}';
      });
    }
  }

  Widget _buildButtonAddSchedule() {
    return ListTile(
      title: Text(
        'Añadir otro',
      ),
      trailing: Icon(Icons.add_circle, color: Colors.blue),
      onTap: () {
        _selectHours(context);
      },
      tileColor: Colors.blue[100],
    );
  }

  Widget _crearLista() {
    schedules = schedule.split(_split);
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: schedules.length,
      itemBuilder: (BuildContext context, int index) {
        final sche = schedules[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
          child: ListTile(
              title: Text(sche),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () => _deleteFromScheduleList(index),
              )),
          onDismissed: (direction) => _deleteFromScheduleList(index),
        );
      },
    );
  }

  void _deleteFromScheduleList(int index) {
    setState(() {
      schedules.removeAt(index);
      schedule = '';
      for (int i = 0; i < schedules.length; i++) {
        if (i == 0) {
          schedule = schedule + schedules[i];
        } else {
          schedule = schedule + _split + schedules[i];
        }
      }
      medicament.schedule = schedule;
    });
  }

  Widget _step4Content() {
    return Column(
      children: [
        _crearLista(),
        _buildButtonAddSchedule(),
      ],
    );
  }

  void _deleteMedicament() {
    MedicamentService.deleteMedicament(medicament);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
        context: context,
        //Si es true si toca afuera se cierra
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Confirmar'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿Está seguro que desea eliminarlo?'),
              ],
            ),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              FlatButton(
                  onPressed: _deleteMedicament, child: Text('Confirmar')),
            ],
          );
        });
  }

  Widget checkboxHaveFinalDate() {
    return Row(
      children: [
        Checkbox(
            value: medicament.duration.haveFinalDate,
            onChanged: (valor) {
              setState(() {
                medicament.duration.haveFinalDate = valor;
              });
            }),
        Text(
          'Establecer fecha final',
          style: TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
