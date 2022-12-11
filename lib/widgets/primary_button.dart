import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isDense = false,
    this.enabled = true,
    this.color,
  }) : super(key: key);

  final Function() onPressed;
  final bool enabled;
  final String label;
  final bool isDense;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: enabled ? (color ?? primaryColor) : neutralColor,
        visualDensity: isDense ? VisualDensity.compact : VisualDensity.standard,
        minimumSize: const Size(60, 50),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
