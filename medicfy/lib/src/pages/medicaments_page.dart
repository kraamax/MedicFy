import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicfy/src/models/medicament.dart';
import 'package:medicfy/src/services/medicament.service.dart';
import 'package:medicfy/utils/my_flutter_app_icons.dart';

class MedicamentsPage extends StatefulWidget {
  @override
  _MedicamentsPageState createState() => _MedicamentsPageState();
}

class _MedicamentsPageState extends State<MedicamentsPage> {
  Future<List<Medicament>> medicaments;
  @override
  void initState() {
    super.initState();

    medicaments = MedicamentService.getMedicaments().then((data) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    medicaments = null;
    medicaments = MedicamentService.getMedicaments();
    return Scaffold(
      /*appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 10.0),
            Text('Medicamentos'),
            SizedBox(width: 8.0),
            Icon(MyFlutterApp.pills),
          ],
        ),
      ),*/
      body: _lista(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.of(context).pushNamed('addMedicament').then((value) {
          setState(() {
            medicaments = MedicamentService.getMedicaments();
            (context as Element).rebuild();
          });
        }),
        icon: Icon(Icons.add),
        label: Text('Agregar'),
      ),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: medicaments,
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              // here we are showing loading view in waiting state.
              return loadingView();
            }
          case ConnectionState.active:
            {
              return SizedBox();
            }
          case ConnectionState.done:
            {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                children: _cardList(snapshot.data, context),
              );
            }
          case ConnectionState.none:
            {
              return SizedBox();
            }
          default:
            {
              return SizedBox();
            }
        }
        ;
      },
    );
  }

  Widget loadingView() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.red,
      ),
    );
  }

  List<Widget> _cardList(List<dynamic> data, BuildContext context) {
    final List<Widget> widgets = [];

    data.forEach((opt) {
      final widgetTemp = Card(
        elevation: 3.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: _cardData(opt),
      );
      widgets.add(widgetTemp);
    });
    return widgets;
  }

  Widget _cardData(dynamic opt) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, 'updateMedicament', arguments: opt.toMap())
            .then((value) {
          setState(() {
            medicaments = MedicamentService.getMedicaments().then((value) {
              (context as Element).rebuild();
            });
          });
        });
      },
      title: Text(opt.medicamentName),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(opt.schedule),
          Expanded(child: SizedBox()),
          Text(opt.frequency.type),
          SizedBox(width: 30)
        ],
      ),
      leading: Icon(
        MyFlutterApp.pill,
        color: Colors.pink[200],
        size: 32.0,
      ),
    );
  }
}
