

import 'package:flutter/cupertino.dart';

class MyCustomPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

    path.lineTo(0, size.height * 0.50);
    path.cubicTo(size.width * 0.27, size.height * 0.80, size.width * 0.66, size.height * 0.10, size.width, size.height * 0.90);
    path.lineTo((size.width), 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}