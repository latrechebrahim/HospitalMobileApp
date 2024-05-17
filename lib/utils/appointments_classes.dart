import 'package:flutter/material.dart';
import 'package:hospital_managements/utils/app_styles.dart';

class Appointments_Statistics extends StatelessWidget {
  const Appointments_Statistics({
    super.key,
    required this.sh,
    required this.sw,
  });

  final double sh;
  final double sw;

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 200,
            width:  400,
            decoration: BoxDecoration(
              color: AppTheme.dark,
              borderRadius: BorderRadius.circular(31),
            ),
          );
  }
}