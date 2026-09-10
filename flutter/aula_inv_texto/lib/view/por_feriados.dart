import 'package:flutter/material.dart';
import 'package:aula_inv_texto/service/invertexto_service.dart';

class PorFeriados extends StatefulWidget {
  @override
  _PorFeriadosState createState() => _PorFeriadosState();
}

class _PorFeriadosState extends State<PorFeriados> {
  String? campo;
  String estadoSelecionado = 'PR';
  
  final List<String> estados = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 
    'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 
    'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];

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
            
            DropdownButtonFormField<String>(
              initialValue: estadoSelecionado,
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: const InputDecoration(
                labelText: "Selecione o Estado",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              items: estados.map((String uf) {
                return DropdownMenuItem<String>(
                  value: uf,
                  child: Text(uf),
                );
              }).toList(),
              onChanged: (novoEstado) {
                setState(() {
                  estadoSelecionado = novoEstado!;
                });
              },
            ),
            const SizedBox(height: 15),

            TextField(
              decoration: const InputDecoration(
                labelText: "Digite o Ano",
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
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: apiService.buscaFeriados(campo, estado: estadoSelecionado),
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
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                snapshot.error.toString().replaceAll("Exception: ", ""),
                                style: const TextStyle(color: Colors.red, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          return exibeResultado(context, snapshot);
                        }
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget exibeResultado(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    String listaFeriados = '';

    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
      for (var feriado in snapshot.data!) {
        String date = feriado["date"] ?? "";
        String name = feriado["name"] ?? "Feriado";
        String type = (feriado["type"] ?? "nacional").toString().toUpperCase();

        listaFeriados += "$date - $name ($type)\n\n";
      }
    } else {
      listaFeriados = "Nenhum feriado encontrado.";
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            listaFeriados.trim(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            softWrap: true,
          ),
        ),
      ),
    );
  }
}