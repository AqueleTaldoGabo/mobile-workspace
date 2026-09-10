import 'package:flutter/material.dart';
import 'package:aula_inv_texto/service/invertexto_service.dart';

class PorConversao extends StatefulWidget {
  @override
  _PorConversaoState createState() => _PorConversaoState();
}

class _PorConversaoState extends State<PorConversao> {
  String? campo;
  String moedaOrigem = 'BRL';
  String moedaDestino = 'USD';
  
  final List<String> moedas = ['BRL', 'USD', 'EUR', 'GBP', 'JPY', 'CAD'];
  final apiService = InvertextoApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/splashscreen.jpg',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Digite o valor",
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

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: moedaOrigem,
                      dropdownColor: Colors.grey[900],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        labelText: "De",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      items: moedas.map((String moeda) {
                        return DropdownMenuItem<String>(
                          value: moeda,
                          child: Text(moeda),
                        );
                      }).toList(),
                      onChanged: (novoValor) {
                        setState(() {
                          moedaOrigem = novoValor!;
                        });
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: moedaDestino,
                      dropdownColor: Colors.grey[900],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        labelText: "Para",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      items: moedas.map((String moeda) {
                        return DropdownMenuItem<String>(
                          value: moeda,
                          child: Text(moeda),
                        );
                      }).toList(),
                      onChanged: (novoValor) {
                        setState(() {
                          moedaDestino = novoValor!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Executa a busca na API se o valor foi inserido
              if (campo != null && campo!.trim().isNotEmpty)
                FutureBuilder(
                  future: apiService.converteMoeda(
                    campo!, 
                    moedaOrigem, 
                    moedaDestino,
                  ),
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
                            ),
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
    if (snapshot.data == null) return const SizedBox.shrink();

    final double total = snapshot.data['total'] ?? 0.0;
    final String moeda = snapshot.data['moedaDestino'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        "Resultado: ${total.toStringAsFixed(2)} $moeda",
        style: const TextStyle(color: Colors.white, fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}