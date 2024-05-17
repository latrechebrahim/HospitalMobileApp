import 'package:flutter/material.dart';
import 'package:hospital_managements/utils/app_styles.dart';


class ElevatedButtonPressed extends StatelessWidget {
   ElevatedButtonPressed({
    super.key,
    required this.text,
    required this.icon,
    required this.x,
    required this.y, 
    required this.targetPage,

  });
  final WidgetBuilder targetPage;
  final String text;
  final IconData icon;
  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: targetPage ),
            );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(x, y)),
                foregroundColor:
                    MaterialStateProperty.all(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all(AppTheme.blue),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: AppTheme.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppTheme.white,
                    ),
                  ),
                ],
              ),
            );
  }
}

class ElevatedButtonNotPressed extends StatelessWidget {
  const ElevatedButtonNotPressed({
    super.key,
    required this.text,
    required this.icon,
    required this.x,
    required this.y, 
    required this.targetPage,
  });
  final WidgetBuilder targetPage;
  final String text;
  final IconData icon;
  final double x;
  final double y;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: () {
                              
              Navigator.push(
              context,
              MaterialPageRoute(builder: targetPage ),
            );

              },
              style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all(Size(x, y))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: AppTheme.blue),
                  SizedBox(width: 8),
                  Text(
                      text,
                      style: TextStyle(
                      color: AppTheme.blue,
                    ),
                  ),
                ],
              ),
            );
  }
}