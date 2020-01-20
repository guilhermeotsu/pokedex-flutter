import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/consts/consts_api.dart';
import 'package:pokemon/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.num, this.types})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _doTitle(),
                        _doSubTitle(),
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Stack(
                  children: <Widget>[
                    _doImagePokedex(),
                    _doImagePokemon(),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: ConstsApi.getColorType(
            type: types[0],
          ),
          // deixa as bordas arredondadas
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _doSubTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _setTipos(),
    );
  }

  Widget _doTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: 'Google',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _setTipos() {
    List<Widget> lista = [];
    types.forEach((nome) {
      lista.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _doImagePokedex() {
    return Opacity(
      child: Image.asset(
        ConstsApp.whitePokeball,
        width: 100.0,
        height: 100.0,
      ),
      opacity: 0.2,
    );
  }

  Widget _doImagePokemon() {
    return CachedNetworkImage(
      width: 90.0,
      height: 90.0,
      placeholder: (context, url) => new Container(
        // o que aparece na imagem qndo estiver sendo carregada
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
    );
  }
}
