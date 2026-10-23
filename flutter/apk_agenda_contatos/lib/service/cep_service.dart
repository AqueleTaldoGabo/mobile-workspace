
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';


class CepService {
  final String _token = "28240|F4fFJ9dhInUoT3jPQyAJNKafuj9IGwoE";

  Future<Map<String, dynamic>> buscaCEP(String? valor) async {
    try {
      if (valor == null || valor.trim().isEmpty) {
        throw Exception('Por favor, digite um CEP antes de buscar.');
      }

      final cepLimpo = valor.replaceAll(RegExp(r'[^0-9]'), '');
      if (cepLimpo.length != 8) {
        throw Exception('O CEP deve conter exatamente 8 dígitos numéricos.');
      }

      final uri = Uri.parse(
        "https://api.invertexto.com/v1/cep/$cepLimpo?token=$_token",
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.isEmpty || data.containsKey('error')) {
          throw Exception('CEP não localizado na base de dados.');
        }
        return data;
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        throw Exception('CEP informado não foi encontrado.');
      } else if (response.statusCode == 429) {
        throw Exception('Limite de buscas atingido. Aguarde um momento.');
      } else if (response.statusCode == 401) {
        throw Exception('Serviço temporariamente indisponível.');
      } else {
        throw Exception('Ocorreu um erro na consulta. Tente novamente.');
      }
    } on SocketException {
      throw Exception('Sem conexão com a internet. Verifique sua rede.');
    } catch (e) {
      rethrow;
    }
  }
}
