import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
  }) : super(key: key);

  final Function() onPressed;
  final String label;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 34),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
