import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'dart:io';

class DoctorsCard extends StatefulWidget {
  final String Name;
  final String photo;
  final String Phone_number;
  final String Specialization;

  const DoctorsCard({
    super.key,
    required this.Name,
    required this.photo,
    required this.Phone_number,
    required this.Specialization,
  });

  @override
  _DoctorsCardState createState() => _DoctorsCardState();
}

class _DoctorsCardState extends State<DoctorsCard> {
  @override
  Widget build(BuildContext context) {
    var Name = widget.Name;
    var photo = widget.photo;
    var Specialization = widget.Specialization;
    var Phone_number = widget.Phone_number;

    return SizedBox(
      height: 150,
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
                  Icons.star,
                  color: AppTheme.white,
                ),
                onPressed: () {},
              ),
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: AppTheme.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        Phone_number,
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                                height: 142,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                      bottomStart: Radius.circular(20),
                                      topStart: Radius.circular(20)),
                                  image: DecorationImage(
                                    image: widget.photo.isNotEmpty
                                        ? FileImage(File(widget.photo) as File)
                                    as ImageProvider<Object>
                                        : AssetImage('images/person.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          Gap(10),
                          Container(
                            child: Column(
                              children: [
                                Gap(15),
                                Text(
                                  Name,
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Gap(10),
                                Text(
                                  Specialization,
                                  style: TextStyle(
                                      color: AppTheme.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
