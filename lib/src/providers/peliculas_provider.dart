import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart'
    as http; //esto aqui espone el paquete dentro de esa variable, entonces accedo a los metodos usando http.

class PeliculasProvider {
  String _apikey = '13b612dd30cfe0b859157682b9d3074c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;

  List<Pelicula> _populares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Actor>> procesarActor(int id) async {
    final url = Uri.https(_url, '3/movie/$id/credits', {'api_key': _apikey});

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final castActores = Cast.fromJsonList(decodedData['cast']);
    return castActores.actores;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<void> getPopularMovie() async {
    _popularesPage++;

    print('Cargando siguientes...');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);

    popularesSink(_populares);

    // return resp;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }
}
