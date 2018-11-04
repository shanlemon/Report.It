import 'package:flutter/material.dart';

class ButtonColumn extends StatefulWidget {

  final bool _active;
  final IconData _icon;
  final String _text;

  ButtonColumn(this._active, this._icon, this._text);

  @override
  _ButtonColumnState createState() => _ButtonColumnState(_active, _icon, _text);
}

class _ButtonColumnState extends State<ButtonColumn> {

  bool _active;
  final IconData _icon;
  final String _text;

  _ButtonColumnState(this._active, this._icon, this._text);

  @override
  Widget build(BuildContext context) {

    Color col = _active ? Theme.of(context).primaryColor : Colors.black;

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_icon, color: col, size: 48.0),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              _text,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: col,
              ),
            ),
          ),
        ],
      );
  }
}