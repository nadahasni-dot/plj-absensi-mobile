import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/config/theme.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/widgets/shimmer_wrapper.dart';

class AkunPageLoading extends StatelessWidget {
  const AkunPageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(78),
              child: ShimmerWrapper(
                child: Container(
                  width: 78,
                  height: 78,
                  color: neutralColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: ShimmerWrapper(
              child: Container(
                height: 18,
                width: 80,
                decoration: BoxDecoration(
                  color: neutralColor,
                  borderRadius: smallBorder,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: ShimmerWrapper(
              child: Container(
                height: 14,
                width: 100,
                decoration: BoxDecoration(
                  color: neutralColor,
                  borderRadius: smallBorder,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const AkunPageMenuLoading(),
          const SizedBox(height: 8),
          const AkunPageMenuLoading(),
          const SizedBox(height: 8),
          const AkunPageMenuLoading(),
          const SizedBox(height: 8),
          const AkunPageMenuLoading(),
          const SizedBox(height: 8),
          const AkunPageMenuLoading(),
          const SizedBox(height: 8),
          const AkunPageMenuLoading(),
          const SizedBox(height: 8),
          const AkunPageMenuLoading(),
        ],
      ),
    );
  }
}

class AkunPageMenuLoading extends StatelessWidget {
  const AkunPageMenuLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: defaultBorder,
        boxShadow: [defaultShadow],
      ),
      child: Row(
        children: [
          ShimmerWrapper(
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: neutralColor,
                borderRadius: smallBorder,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ShimmerWrapper(
              child: Container(
                height: 24,
                decoration: BoxDecoration(
                  color: neutralColor,
                  borderRadius: smallBorder,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
          ShimmerWrapper(
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: neutralColor,
                borderRadius: smallBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
