import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/utilities/responsive_util.dart';
import 'package:plj_absensi_mobile/widgets/shimmer_wrapper.dart';

class TimeCardLoading extends StatelessWidget {
  const TimeCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: defaultBorder,
      child: Ink(
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [defaultShadow],
          borderRadius: defaultBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ShimmerWrapper(
                  child: Container(
                    height: 16,
                    width: 120,
                    decoration: BoxDecoration(
                      color: neutralColor,
                      borderRadius: smallBorder,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: ResponsiveUtil(context).byWidth * 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerWrapper(
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ShimmerWrapper(
                        child: Container(
                          height: 14,
                          width: 60,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: smallBorder,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ShimmerWrapper(
                        child: Container(
                          height: 16,
                          width: 50,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: smallBorder,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: ResponsiveUtil(context).byWidth * 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerWrapper(
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ShimmerWrapper(
                        child: Container(
                          height: 18,
                          width: 60,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: smallBorder,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ShimmerWrapper(
                        child: Container(
                          height: 18,
                          width: 50,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: smallBorder,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: ResponsiveUtil(context).byWidth * 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerWrapper(
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ShimmerWrapper(
                        child: Container(
                          height: 18,
                          width: 60,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: smallBorder,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ShimmerWrapper(
                        child: Container(
                          height: 18,
                          width: 50,
                          decoration: BoxDecoration(
                            color: neutralColor,
                            borderRadius: smallBorder,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
