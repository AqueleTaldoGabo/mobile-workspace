import 'package:aula_inv_texto/view/busca_cep_page.dart';
import 'package:aula_inv_texto/view/por_conversao_page.dart';
import 'package:aula_inv_texto/view/por_extenso_page.dart';
import 'package:aula_inv_texto/view/por_feriados.dart';
import 'package:aula_inv_texto/view/validador_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/splashscreen.jpg',
            fit: BoxFit.contain,
            height: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: [GestureDetector(
          child: Row(
            children: [
              Icon(Icons.edit,
              color: Colors.white, size: 50.0),
              SizedBox(width: 30),
              Text("Por extenso",
              style: TextStyle(
                color: Colors.white, fontSize: 20.0)),
            ],
          ),
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => PorExtenso()));
          },
        ),
        GestureDetector(
          child: Row(
            children: [
              Icon(Icons.home,
              color: Colors.white, size: 50.0),
              SizedBox(width: 30),
              Text("Por busca cep",
              style: TextStyle(
                color: Colors.white, fontSize: 20.0)),
            ],
          ),
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => BuscaCep()));
          },
        ),
        GestureDetector(
          child: Row(
            children: [
              Icon(Icons.money,
              color: Colors.white, size: 50.0),
              SizedBox(width: 30),
              Text("Por conversão",
              style: TextStyle(
                color: Colors.white, fontSize: 20.0)),
            ],
          ),
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => PorConversao()));
          }
        ),
        GestureDetector(
          child: Row(
            children: [
              Icon(Icons.perm_identity,
              color: Colors.white, size: 50.0),
              SizedBox(width: 30),
              Text("Por validar documento",
              style: TextStyle(
                color: Colors.white, fontSize: 20.0)),
            ],
          ),
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => Validador()));
          }
        ),
        GestureDetector(
          child: Row(
            children: [
              Icon(Icons.calendar_month,
              color: Colors.white, size: 50.0),
              SizedBox(width: 30),
              Text("Por checar feriados",
              style: TextStyle(
                color: Colors.white, fontSize: 20.0)),
            ],
          ),
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => PorFeriados()));
          }
        )
        ]),
      ),
    );
  }
}