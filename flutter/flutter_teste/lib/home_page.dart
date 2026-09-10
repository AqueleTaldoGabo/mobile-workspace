import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: const Text('Hello world')
    );
  }
}