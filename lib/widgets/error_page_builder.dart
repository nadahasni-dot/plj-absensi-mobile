import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/widgets/no_data.dart';
import 'package:plj_absensi_mobile/widgets/under_development.dart';

import '../../../widgets/no_connection.dart';
import '../../../widgets/server_error.dart';
import '../../../widgets/timeout.dart';

class ErrorPageBuilder extends StatelessWidget {
  static const noData = 'tidak ada data';
  static const underDevelopment = 'dalam pengembangan';

  const ErrorPageBuilder({
    Key? key,
    required this.error,
    required this.onPressed,
  }) : super(key: key);

  final String error;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      child: Builder(builder: (context) {
        if (error.toLowerCase().contains('dalam pengembangan')) {
          return const UnderDevelopment();
        }

        if (error.toLowerCase().contains('tidak ada data')) {
          return NoData(onPressed: () {
            onPressed();
          });
        }

        if (error.toLowerCase().contains('tidak ada koneksi')) {
          return NoConnection(onPressed: () {
            onPressed();
          });
        }

        if (error.toLowerCase().contains('timeout')) {
          return Timeout(onPressed: () {
            onPressed();
          });
        }

        return ServerError(onPressed: () {
          onPressed();
        });
      }),
    );
  }
}
