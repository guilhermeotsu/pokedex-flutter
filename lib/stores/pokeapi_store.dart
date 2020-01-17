import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokemon/consts/consts_api.dart';
import 'package:pokemon/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeApi pokeAPI;

  @action
  fetchPokemonList() {
    // so vai ser executado apos o future estiver completo
    loadPokeApi().then((pokeList) {
      pokeAPI = pokeList;
    });
  }

  Future<PokeApi> loadPokeApi() async {
    try {
      final response = await http.get(ConstsApi.pokeApiUrl);
      var decodeJson = jsonDecode(response.body);
      return PokeApi.fromJson(decodeJson);
    } catch (erro) {
      print('Erro ao carregar a lista');
      return null;
    }
  }
}
