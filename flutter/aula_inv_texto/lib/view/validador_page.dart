import 'package:flutter/material.dart';
import 'package:aula_inv_texto/service/invertexto_service.dart';

class Validador extends StatefulWidget {
  @override
  _ValidadorState createState() => _ValidadorState();
}

class _ValidadorState extends State<Validador> {
  String? campo;
  String tipoDocumento = 'cpf';
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
              initialValue: tipoDocumento,
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: const InputDecoration(
                labelText: "Tipo de Documento",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'cpf', child: Text('CPF')),
                DropdownMenuItem(value: 'cnpj', child: Text('CNPJ')),
              ],
              onChanged: (novoTipo) {
                setState(() {
                  tipoDocumento = novoTipo!;
                });
              },
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Digite o ${tipoDocumento.toUpperCase()}",
                labelStyle: const TextStyle(color: Colors.white),
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
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
                future: apiService.validaDocumento(campo, tipoDocumento),
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
    final bool isValid = snapshot.data?["valid"] ?? false;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        isValid ? "Documento é válido" : "Documento é inválido",
        style: const TextStyle(color: Colors.white, fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}