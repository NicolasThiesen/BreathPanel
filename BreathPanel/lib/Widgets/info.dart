import 'package:flutter/material.dart';

Future<void> infoDialog( context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Como Usar?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Primeiramente conecte o cabo do respirador/controlador junto ao tablet ou outro dispositivo em que você esteja usando.\nApós conectar clique no botão que irá aparecer na tela dizendo "Conectar", embaixo de "Portas seriais Disponíveis".\nDepois desse procedimento clique no botão "Modo do Respirador" e pronto você terá seu Painel de Monitoramento configurado com exito.'),

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