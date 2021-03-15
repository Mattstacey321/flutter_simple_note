import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeypadIcons {
  static const _iconSize = 30.0;
  static _buildIcon(Widget child, {@required String message}) => Tooltip(
        message: message,
        child: Container(
          height: _iconSize,
          width: _iconSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          child: FittedBox(
            child: child,
            fit: BoxFit.scaleDown,
          ),
        ),
      );

  static Widget control = _buildIcon(Icon(EvaIcons.arrowUp),message: "Control");
  static Widget keyA = _buildIcon(Text("A"),message: "Key A");
  static Widget keyB = _buildIcon(Text("B"), message: "Key B");
  static Widget keyC = _buildIcon(Text("C"), message: "Key C");
  static Widget keyD = _buildIcon(Text("D"), message: "Key D");
  static Widget keyE = _buildIcon(Text("E"), message: "Key E");
  static Widget keyF = _buildIcon(Text("F"), message: "Key F");
  static Widget keyG = _buildIcon(Text("G"), message: "Key G");
  static Widget keyH = _buildIcon(Text("H"), message: "Key H");
  static Widget keyI = _buildIcon(Text("I"), message: "Key I");
  static Widget keyL = _buildIcon(Text("L"), message: "Key L");
  static Widget keyK = _buildIcon(Text("K"), message: "Key K");
  static Widget keyM = _buildIcon(Text("M"), message: "Key M");
  static Widget keyN = _buildIcon(Text("N"), message: "Key N");
  static Widget keyO = _buildIcon(Text("O"), message: "Key O");
  static Widget keyP = _buildIcon(Text("P"), message: "Key P");
  static Widget keyQ = _buildIcon(Text("Q"), message: "Key Q");
  static Widget keyR = _buildIcon(Text("R"), message: "Key R");
  static Widget keyS = _buildIcon(Text("S"), message: "Key S");
  static Widget keyT = _buildIcon(Text("T"), message: "Key T");
}
