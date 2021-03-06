import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokemon/consts/consts_app.dart';
import 'package:pokemon/models/pokeapi.dart';
import 'package:pokemon/pages/widgets/home_appbar.dart';
import 'package:pokemon/pages/widgets/poke_item.dart';
import 'package:pokemon/stores/pokeapi_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeApiStore;
  @override
  void initState() {
    super.initState();
    pokeApiStore = PokeApiStore();
    // pegando a lista de pokemon da api
    pokeApiStore.fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    // pegando o tamanho da tela
    var screenWidth = MediaQuery.of(context).size.width;

    // pegando o tamanho do status bar
    var statusBarWidth = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        // faz com que vc possa ultrapassar as margens
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(240 / 4.7),
            left: screenWidth - (240 / 1.6), // pokeball na direita
            child: _doPositionedDarkPokeball(),
          ),
          Container(
            child: Column(
              children: <Widget>[
                _noOvertakeStatusBar(statusBarWidth),
                AppBarHome(),
                _doListPokemon(pokeApiStore),
              ],
            ),
          ),
        ],
      ), // empilhamento de widgets
    );
  }

  Widget _doListPokemon(PokeApiStore pokeApiStore) {
    return Expanded(
      child: Container(
        child: Observer(
          name: 'ListaHomePage',
          builder: (BuildContext context) {
            PokeApi _pokeApi = pokeApiStore.pokeAPI;
            print(_pokeApi.pokemon);
            return _pokeApi != null
                ? AnimationLimiter(
                    child: GridView.builder(
                      physics:
                          BouncingScrollPhysics(), // faz o efeito de "elasticidade na lista"
                      padding: EdgeInsets.all(12.0),
                      addAutomaticKeepAlives:
                          true, // nao fica recriando os itens conforme for para cima/baixo
                      gridDelegate: // qnte de colunas
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: pokeApiStore.pokeAPI.pokemon.length,
                      itemBuilder: (context, index) {
                        Pokemon pokemon = pokeApiStore.getPokemon(index: index);

                        //https://pub.dev/packages/flutter_staggered_animations
                        return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: GestureDetector(
                                child: PokeItem(
                                  types: pokemon.type,
                                  index: index,
                                  name: pokemon.name,
                                  num: pokemon.num,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Container(), // pokedetail page
                                    ),
                                  );
                                },
                              ),
                            ));
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  Widget _noOvertakeStatusBar(statusBarWidth) {
    return Container(
      height: statusBarWidth,
    );
  }

  Widget _doPositionedDarkPokeball() {
    return Opacity(
      opacity: 0.1,
      child: Image.asset(
        ConstsApp.darkPokeball,
        height: 240,
        width: 240,
      ),
    );
  }
}
