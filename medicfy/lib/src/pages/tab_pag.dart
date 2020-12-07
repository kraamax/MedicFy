import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medicfy/src/pages/add_user_page.dart';
import 'package:medicfy/src/pages/home_page.dart';
import 'package:medicfy/src/pages/login_page.dart';
import 'package:medicfy/src/pages/medicaments_page.dart';
import 'package:medicfy/src/routes/routes.dart';
import 'package:medicfy/utils/my_flutter_app_icons.dart';

class TabPage extends StatelessWidget {
  List<Widget> pages = [
    MedicamentsPage(),
    MedicamentsPage(),
    AddUserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('MedicFy'),
            bottom: TabBar(
                tabs: choices.map<Widget>((Choice choice) {
              return Tab(
                text: choice.title,
                icon: Icon(choice.icon),
              );
            }).toList()),
          ),
          body: TabBarView(
            children: pages,
          ),
        ));
  }
}

class Choice {
  final String title;
  final IconData icon;
  const Choice({this.title, this.icon});
}

const List<Choice> choices = <Choice>[
  Choice(title: 'INICIO', icon: Icons.home),
  Choice(title: 'MEDICAMENTOS', icon: MyFlutterApp.pills),
  Choice(title: 'SOCIAL', icon: Icons.account_circle),
];

class ChoicePage extends StatelessWidget {
  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              choice.icon,
              size: 150.0,
              color: textStyle.color,
            ),
            Text(
              choice.title,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
