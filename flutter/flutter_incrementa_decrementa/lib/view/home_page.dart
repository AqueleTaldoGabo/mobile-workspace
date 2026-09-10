import 'package:flutter/material.dart';
import 'package:flutter_incrementa_decrementa/view/busca_cep_page.dart';
import 'package:flutter_incrementa_decrementa/view/por_extenso_page.dart';

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
            Image.asset('assets/imgs/campodefutebol.jpg',
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
              Icon(Icons.edit,
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
        )]),
      ),
    );
  }
}