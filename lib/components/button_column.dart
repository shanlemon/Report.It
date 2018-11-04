import 'package:flutter/material.dart';

class ButtonColumn extends StatelessWidget {

  final bool active;
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  ButtonColumn(this.active, this.icon, this.text, this.onPressed);
  @override
  Widget build(BuildContext context) {

    Color col = active ? Theme.of(context).primaryColor : Colors.black;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: col, size: 48.0),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: col,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
  // @override
  // _ButtonColumnState createState() => _ButtonColumnState(active, icon, text, onPressed);
}

// class _ButtonColumnState extends State<ButtonColumn> {

//   bool _active;
//   final IconData _icon;
//   final String _text;
//   final VoidCallback _onPressed;

//   _ButtonColumnState(this._active, this._icon, this._text, this._onPressed);

//   @override
//   Widget build(BuildContext context) {

//     Color col = _active ? Theme.of(context).primaryColor : Colors.black;

//     return InkWell(
//       onTap: _onPressed,
//       child: Container(
//         padding: EdgeInsets.only(left: 5.0, right: 5.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(_icon, color: col, size: 48.0),
//             Container(
//               margin: const EdgeInsets.only(top: 8.0),
//               child: Text(
//                 _text,
//                 style: TextStyle(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w400,
//                   color: col,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
    
//   }
// }