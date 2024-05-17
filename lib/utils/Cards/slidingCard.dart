import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'dart:io';

class SlidingCard extends StatefulWidget {
  final String title;
  final bool isConfirmead;
  final String subtitle;
  final String image;
  final String NameDoctors;
  final String date;

  const SlidingCard({
    super.key,
    required this.NameDoctors,
    required this.date,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.isConfirmead,
  });

  @override
  _SlidingCardState createState() => _SlidingCardState();
}

class _SlidingCardState extends State<SlidingCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.blue[900],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Positioned(
              top: 1,
              right: 1,
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: AppTheme.white,
                ),
                onPressed: () {

                },
              ),
            ),
            widget.isConfirmead
                ? Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                            width: 160,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadiusDirectional.circular(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Confirmead',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                  )
                : Positioned(
                    bottom: 10,
                    right: 10,
                    child:  SizedBox(
                      width: 160,
                      height: 40,
                      child: ClipRRect(
                          borderRadius:
                          BorderRadiusDirectional.circular(16),
                              child: LiquidCustomProgressIndicator(
                                value: 0.5, // Defaults to 0.5.
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.green),
                                backgroundColor: Colors.red[900],
                                direction: Axis.horizontal,
                                shapePath: _buildBoatPath(),
                                center: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      OctIcons.chevron_right,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'in progress',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(100),
                                    image: DecorationImage(
                                      image: widget.image.isNotEmpty
                                          ? FileImage(File(widget.image) as File)
                                      as ImageProvider<Object>
                                          : AssetImage('images/person.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.NameDoctors,
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Gap(25),
                            Container(

                              child: Column(
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyle(color: AppTheme.white),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    widget.subtitle,
                                    style: TextStyle(color: AppTheme.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 80),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      widget.isConfirmead
                          ? Container(

                              child: Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: AppTheme.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.date,
                                    style: TextStyle(
                                      color: AppTheme.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Path _buildBoatPath() {
    // Define the path for the boat shape including the container
    final Path path = Path();

    // Move to the top-left corner of the container
    path.moveTo(0, 0);

    // Draw the container shape
    path.lineTo(0, 40); // Move to the top edge of the container
    path.lineTo(160, 40); // Draw a line to the top-right corner
    path.lineTo(160, 0); // Draw a line to the bottom-right corner
    path.lineTo(0, 0); // Draw a line to the bottom-left corner
    path.close(); // Close the path

    // Return the path
    return path;
  }
}
