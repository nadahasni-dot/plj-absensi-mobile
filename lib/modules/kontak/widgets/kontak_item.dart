import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class KontakItem extends StatelessWidget {
  const KontakItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.description,
  }) : super(key: key);

  final VoidCallback onTap;
  final String icon;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: defaultBorder,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: white,
          borderRadius: defaultBorder,
          boxShadow: [defaultShadow],
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: black),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: textDarkGreyColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/icons/chevron-right.svg'),
          ],
        ),
      ),
    );
  }
}
