import 'package:flutter/material.dart';
import 'package:medicfy/src/pages/add_medicament_page.dart';
import 'package:medicfy/src/pages/add_user_page.dart';
import 'package:medicfy/src/pages/home_page.dart';
import 'package:medicfy/src/pages/login_page.dart';

import 'package:medicfy/src/pages/medicaments_page.dart';
import 'package:medicfy/src/pages/tab_pag.dart';
import 'package:medicfy/src/pages/update_medicament_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'medicaments': (BuildContext context) => MedicamentsPage(),
    'addMedicament': (BuildContext context) => AddMedicamentPage(),
    'updateMedicament': (BuildContext context) => UpdateMedicamentPage(),
    'tabPage': (BuildContext context) => TabPage(),
    'addUser': (BuildContext context) => AddUserPage(),
    'login': (BuildContext context) => LoginPage(),
  };
}
