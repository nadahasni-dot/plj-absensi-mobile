import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: neutralColor,
      highlightColor: mainLayerColor,
      child: child,
    );
  }
}
