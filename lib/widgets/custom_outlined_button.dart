import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isDense = false,
  }) : super(key: key);

  final Function() onPressed;
  final String label;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: mainLayerColor,
        visualDensity: isDense ? VisualDensity.compact : VisualDensity.standard,
        minimumSize: const Size(60, 45),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: textDarkColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
