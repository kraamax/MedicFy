import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/background1.jpeg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        )
      ],
    );
  }

  Widget _createButton(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Medicamentos'),
          leading: Icon(Icons.medical_services),
          onTap: () => Navigator.pushNamed(context, 'medicaments'),
        )
      ],
    );
  }
}
