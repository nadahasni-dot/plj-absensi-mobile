import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.label,
    this.suffix,
  }) : super(key: key);

  final VoidCallback onTap;
  final String icon;
  final String label;
  final Widget? suffix;

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
              child: Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            suffix != null
                ? suffix!
                : SvgPicture.asset('assets/icons/chevron-right.svg'),
          ],
        ),
      ),
    );
  }
}
