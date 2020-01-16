import 'package:flutter/material.dart';
import 'package:pokemon/consts/const_app.dart';
import 'package:pokemon/pages/widgets/home_appbar.dart';

class HomePage extends StatelessWidget {
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
                Expanded(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text('Pokemon'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ), // empilhamento de widgets
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
