import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class InvertextoApiService {
  final String _token = "28240|F4fFJ9dhInUoT3jPQyAJNKafuj9IGwoE";

  Future<Map<String, dynamic>> convertePorExtenso(String? valor) async {
    try {
      if (valor == null || valor.trim().isEmpty) {
        throw Exception('Por favor, digite um número antes de buscar.');
      }

      if (!RegExp(r'^\d+([.,]\d+)?$').hasMatch(valor.trim())) {
        throw Exception('Digite apenas números válidos (ex: 100 ou 10.5).');
      }

      final uri = Uri.parse(
        "https://api.invertexto.com/v1/number-to-words"
        "?token=$_token&number=${valor.trim()}"
        "&currency=BRL&language=pt",
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.isEmpty || data['text'] == null) {
          throw Exception('Não foi possível converter este número.');
        }
        return data;
      } else if (response.statusCode == 422) {
        throw Exception('O número digitado é muito grande para conversão.');
      } else if (response.statusCode == 429) {
        throw Exception('Muitas buscas em pouco tempo. Aguarde alguns instantes.');
      } else if (response.statusCode == 401) {
        throw Exception('Falha de autenticação no serviço. Tente mais tarde.');
      } else {
        throw Exception('Serviço indisponível no momento. Tente novamente.');
      }
    } on SocketException {
      throw Exception('Sem conexão com a internet. Verifique sua rede.');
    } catch (e) {
      rethrow;
    }
  }

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
  Future<Map<String, dynamic>> converteMoeda(String valor, String de, String para) async {
    try {
      if (valor.trim().isEmpty) {
        throw Exception('Digite um valor para conversão.');
      }

      final double valorNum = double.tryParse(valor.replaceAll(',', '.')) ?? 0.0;
      if (valorNum <= 0) {
        throw Exception('Digite um valor numérico válido maior que zero.');
      }

      final parMoedas = "${de}_$para";
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/currency/$parMoedas?token=$_token",
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
      
        if (data.containsKey(parMoedas) && data[parMoedas]['price'] != null) {
          final double cotacao = (data[parMoedas]['price'] as num).toDouble();
          final double totalConvertido = valorNum * cotacao;

          return {
            "total": totalConvertido,
            "cotacao": cotacao,
            "moedaDestino": para,
          };
        } else {
          throw Exception('Sem dados de conversão disponíveis.');
        }
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        throw Exception('Par de moedas não suportado.');
      } else if (response.statusCode == 429) {
        throw Exception('Limite de buscas atingido. Aguarde um momento.');
      } else {
        throw Exception('Erro na consulta (${response.statusCode}).');
      }
    } on SocketException {
      throw Exception('Sem conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }
  Future<Map<String, dynamic>> validaDocumento(String? valor, String tipo) async {
    try {
      if (valor == null || valor.trim().isEmpty) {
        throw Exception('Por favor, digite um documento.');
      }

      final documentoLimpo = valor.replaceAll(RegExp(r'[^0-9]'), '');

      if (documentoLimpo.isEmpty) {
        throw Exception('Digite um documento válido.');
      }

      final uri = Uri.parse(
        "https://api.invertexto.com/v1/validator?token=$_token&value=$documentoLimpo&type=$tipo",
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          throw Exception('Sem resposta do validador.');
        }
        return data;
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        throw Exception('Formato de documento inválido.');
      } else if (response.statusCode == 429) {
        throw Exception('Limite de buscas atingido. Aguarde um instante.');
      } else {
        throw Exception('Erro na consulta (${response.statusCode}).');
      }
    } on SocketException {
      throw Exception('Sem conexão com a internet. Verifique sua rede.');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<dynamic>> buscaFeriados(String? ano, {String estado = 'PR'}) async {
    try {
      if (ano == null || ano.trim().isEmpty) {
        throw Exception('Por favor, digite um ano.');
      }

      final anoLimpo = ano.trim();
      if (anoLimpo.length != 4 || int.tryParse(anoLimpo) == null) {
        throw Exception('Digite um ano válido com 4 dígitos.');
      }

      final uri = Uri.parse(
        "https://api.invertexto.com/v1/holidays/$anoLimpo?token=$_token&state=$estado",
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          throw Exception('Nenhum feriado encontrado.');
        }
        return data;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        throw Exception('Ano ou estado inválido.');
      } else if (response.statusCode == 429) {
        throw Exception('Limite de buscas atingido. Aguarde um instante.');
      } else {
        throw Exception('Erro na consulta (${response.statusCode}).');
      }
    } on SocketException {
      throw Exception('Sem conexão com a internet. Verifique sua rede.');
    } catch (e) {
      rethrow;
    }
  }
}