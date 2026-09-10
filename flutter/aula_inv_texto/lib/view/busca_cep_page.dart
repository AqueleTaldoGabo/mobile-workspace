import 'package:flutter/material.dart';
import 'package:aula_inv_texto/service/invertexto_service.dart';

class BuscaCep extends StatefulWidget {
  @override
  _BuscaCepState createState() => _BuscaCepState();
}

class _BuscaCepState extends State<BuscaCep> {
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
                labelText: "Digite o CEP",
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
            
            // Valida se o campo foi preenchido para evitar erro na API
            if (campo != null && campo!.isNotEmpty)
              FutureBuilder(
                future: apiService.buscaCEP(campo!),
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
    String enderecoCompleto = '';
    if (snapshot.data != null) {
      enderecoCompleto +=
      snapshot.data["street"] ?? "Rua não disponível";
      enderecoCompleto += "\n";
      enderecoCompleto +=
      snapshot.data["neighborhood"] ?? "Bairro não disponível";
      enderecoCompleto += "\n";
      enderecoCompleto +=
      snapshot.data["city"] ?? "Cidade não disponível";
      enderecoCompleto += "\n";
      enderecoCompleto +=
      snapshot.data["state"] ?? "Estado não disponível";
    }
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(enderecoCompleto,
        style: TextStyle(color: Colors.white, fontSize: 18),
        softWrap: true));
  }
}