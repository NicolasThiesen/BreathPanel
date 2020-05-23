import 'package:flutter/material.dart';

Future<void> showMyDialog( context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Você não pode ir para o painel!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Por favor adiocione um dispositivo antes de ir para o painel.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}