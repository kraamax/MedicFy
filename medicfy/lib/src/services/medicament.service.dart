import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:medicfy/src/models/medicament.dart';

class MedicamentService {
  static String base_url = 'http://10.0.2.2:5000/api/medicament';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<List<Medicament>> getMedicaments() async {
    try {
      return await http.get(base_url).then((res) {
        Iterable list = json.decode(res.body);
        List<Medicament> medicamentList = new List();
        medicamentList = list.map((e) {
          return Medicament.fromObject(e);
        }).toList();
        return medicamentList;
      });
    } on TimeoutException catch (e) {
      showToast(e);
      return [];
      // A timeout occurred.
    } on SocketException catch (err) {
      showToast(err);
      return [];
      // Other exception
    }
  }

  static void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2000,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void postMedicament(Medicament medicament) async {
    medicament.medicamentId = 0;
    var _medic = medicament.toMap();
    var body = json.encode(_medic);
    print(_medic);
    await http
        .post(base_url, body: body, headers: header)
        .catchError((onError) {
      print(onError);
    });
  }

  static void puttMedicament(Medicament medicament) async {
    var _medic = medicament.toMap();
    var body = json.encode(_medic);
    print(_medic);
    await http
        .put(base_url + '/${medicament.medicamentId}',
            body: body, headers: header)
        .catchError((onError) {
      print(onError);
    });
  }

  static void deleteMedicament(Medicament medicament) async {
    await http
        .delete(base_url + '/${medicament.medicamentId}', headers: header)
        .catchError((onError) {
      print(onError);
    });
  }
}
