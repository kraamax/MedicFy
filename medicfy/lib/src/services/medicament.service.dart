import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:medicfy/src/models/medicament.dart';

class MedicamentService {
  static String base_url =
      'http://kraamax-001-site1.gtempurl.com/api/medicament';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<List<Medicament>> getMedicaments() async {
    return await http.get(base_url).then((res) {
      Iterable list = json.decode(res.body);
      List<Medicament> medicamentList = new List();
      medicamentList = list.map((e) {
        return Medicament.fromObject(e);
      }).toList();
      return medicamentList;
    });
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

  static Future postMedicament(Medicament medicament) async {
    medicament.medicamentId = 0;
    var _medic = medicament.toMap();
    var body = json.encode(_medic);
    final response = await http
        .post(base_url, body: body, headers: header)
        .catchError((onError) {
      print(onError);
    });
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Fallo al agregar medicamento');
    }
  }

  static Future puttMedicament(Medicament medicament) async {
    var _medic = medicament.toMap();
    var body = json.encode(_medic);
    final response = await http
        .put(base_url + '/${medicament.medicamentId}',
            body: body, headers: header)
        .catchError((onError) {
      print(onError);
    });
    if (response.statusCode == 204) {
      return 'eeeeeeeeeeeeeeeeeeeeeeeee';
    } else {
      throw Exception('Fallo al agregar medicamento');
    }
  }

  static Future deleteMedicament(Medicament medicament) async {
    final response = await http
        .delete(base_url + '/${medicament.medicamentId}', headers: header)
        .catchError((onError) {
      print(onError);
    });

    if (response.statusCode == 204) {
      return response.body;
    } else {
      throw Exception('Fallo al agregar medicamento');
    }
  }
}
