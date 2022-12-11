import 'package:flutter/material.dart';

class ResponsiveUtil {
  BuildContext context;

  ResponsiveUtil(this.context);

  double get byWidth => MediaQuery.of(context).size.width / 414;
  double get byHeight => MediaQuery.of(context).size.height / 865;
}
