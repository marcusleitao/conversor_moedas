import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=cab8db48";

void main() async {

  print(await getData());

  runApp(
      MaterialApp(
          home: Home()
      )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Moeda", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.amber,
        centerTitle: true
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                    "Carregando Dados",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0
                    ),
                    textAlign: TextAlign.center
                )
              );
            default:
              if(snapshot.hasError){
                return Center(
                    child: Text(
                        "Erro ao carregar dados :(",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0
                        ),
                        textAlign: TextAlign.center
                    )
                );
              } else {
                dolar = snapshot.data['results']['currencies']['USD']['buy'];
                euro = snapshot.data['results']['currencies']['EUR']['buy'];
                return Container(color: Colors.green);
              }
          }
        }
      )
    );
  }
}


Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
