import 'package:flutter/material.dart';
import 'package:aula_inv_texto/service/invertexto_service.dart';

class PorExtenso extends StatefulWidget {
  @override
  _PorExtensoState createState() => _PorExtensoState();
}

class _PorExtensoState extends State<PorExtenso> {
  String? campo;
  String? resultado;
  final apiService = InvertextoApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/splashscreen.jpg',
            fit: BoxFit.contain, height: 40),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextField(
              decoration: const InputDecoration(
                labelText: "Digite um Número",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (campo != null && campo!.isNotEmpty)
              FutureBuilder(
                future: apiService.convertePorExtenso(campo!),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString().replaceAll("Exception: ", ""),
                            style: const TextStyle(color: Colors.red, fontSize: 18),
                            textAlign: TextAlign.center,
                          )
                        );
                      } else {
                        return exibeResultado(context, snapshot);
                      }
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget exibeResultado(BuildContext context, AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        snapshot.data["text"] ?? '',
        style: const TextStyle(color: Colors.white, fontSize: 18),
        softWrap: true,
      ),
    );
  }
}