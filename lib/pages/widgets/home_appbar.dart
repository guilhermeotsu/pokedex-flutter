import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _doContainerContainsHamburguerMenuTitle();
  }

  Widget _doContainerContainsHamburguerMenuTitle() {
    return Container(
      height: 120,
      // color: Colors.red,
      child: Column(
        children: <Widget>[
          _doHamburguerMenu(),
          _doTitle(),
        ],
      ),
    );
  }

  Widget _doHamburguerMenu() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 5),
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _doTitle() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Pokedex',
            style: TextStyle(
              fontFamily: 'Google',
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ],
    );
  }
}
