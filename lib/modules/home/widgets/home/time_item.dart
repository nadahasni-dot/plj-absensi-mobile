import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/utilities/responsive_util.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({
    Key? key,
    required this.icon,
    required this.time,
    required this.label,
  }) : super(key: key);

  final String icon;
  final String time;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveUtil(context).byWidth * 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ResponsiveUtil(context).byWidth * 18,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveUtil(context).byWidth * 14,
              color: textDarkGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
