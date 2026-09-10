import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class InvertextoApiService {
  final String _token = "TOkene de voces";
  Future<Map<String, dynamic>> convertePorExtenso(
    String? valor ) async {
      try{
        final uri = Uri.parse(
          "https://api.invertexto.com/v1/number-to-words"
          "?token=$_token&number=$valor"
          "&language-pt""cy=BRL");
          final response = await http.get(uri);
          if (response.stausCode == 200){
            return json.decode(response.body);
          } else{
            throw Exception(
              'Erro ${response.statusCode}: ${response.body}');
          }
      } on SocketException{
        throw Exception('Erro de conexão com a internet');
      } catch(e) { rethrow; }
    }
  Future<Map<String, dynamic>> buscaCEP(
    String? valor ) async {
      try{
        final uri = Uri.parse(
          "https://api.invertexto.com/v1/cep/$valor"
          "?token=$_token");
          final response = await http.get(uri);
          if (response.stausCode == 200){
            return json.decode(response.body);
          } else{
            throw Exception(
              'Erro ${response.statusCode}: ${response.body}');
          }
      } on SocketException{
        throw Exception('Erro de conexão com a internet');
      } catch(e) { rethrow; }
    }
}