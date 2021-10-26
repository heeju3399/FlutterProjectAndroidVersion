import 'package:flutter/material.dart';

class Responsive {
  final Widget widthSmall;
  final Widget widthNormal;
  final Widget widthLarge;

  const Responsive({
     this.widthSmall,
     this.widthNormal,
     this.widthLarge,
  });

  static bool isLarge(BuildContext context) => MediaQuery.of(context).size.width >= 1100;
}
