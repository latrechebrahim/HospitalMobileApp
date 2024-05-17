import 'dart:ui';
import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/utils/app_styles.dart';

import '../services/dio.dart';

class Page_Add_Appointment extends StatefulWidget {
  final Map<String, dynamic> Data;
  const Page_Add_Appointment({
    super.key,
    required this.Data,
  });

  @override
  State<Page_Add_Appointment> createState() => _Page_Add_AppointmentState();
}

class _Page_Add_AppointmentState extends State<Page_Add_Appointment> {
  DioService dioService = DioService();
  late List<String> items;

  @override
  void initState() {
    super.initState();
    items = [];
    fetchSpecialtyFirstnames();
  }


  Future<void> fetchSpecialtyFirstnames() async {
   final specialtyFirstnames = await dioService.fetchSpecialtyFirstnames();
    setState(() {
      items = specialtyFirstnames;
    });
  }
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController DoctorEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.blue,
        title: Text(
          'Add new appointment',
          style: TextStyle(
              color: AppTheme.white, fontSize: 25,),
        ),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Container(
              height: sh,
              width: sw,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFF3B7BC7),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Column(
                        children: [
                          Gap(sh * 0.08),
                          Container(
                            width: sw * 0.9,
                            height: sh * 0.67,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100]?.withOpacity(0.4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlue.withOpacity(.4),
                                  blurRadius: 30,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Gap(sh * 0.04),
                                Container(
                                  height: sh * 0.06,
                                  width: sw * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white?.withOpacity(0.4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.lightBlue.withOpacity(.4),
                                        blurRadius: 30,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Welcome...',
                                        style: GoogleFonts.labrada(
                                          fontSize: 20,
                                          color: AppTheme.dark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(sh * 0.04),
                                Container(
                                  height: sh * 0.06,
                                  width: sw * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white?.withOpacity(0.4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.lightBlue.withOpacity(.4),
                                        blurRadius: 30,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Gap(10),
                                      Text(
                                        'Choose a Doctor',
                                        style: GoogleFonts.labrada(
                                          fontSize: 20,
                                          color: AppTheme.dark,
                                        ),
                                      ),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select Doctor',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: items
                                              .map((item) => DropdownMenuItem(
                                                    value: item,
                                                    child: AutoScrollText(
                                                      curve: Curves.fastOutSlowIn,
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value;
                                              DoctorEditingController.text = value ?? '';
                                            });
                                          },
                                          buttonStyleData:
                                              const ButtonStyleData(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            height: 40,
                                            width: 200,
                                          ),
                                          dropdownStyleData:
                                              const DropdownStyleData(
                                            maxHeight: 400,
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                          ),
                                          dropdownSearchData:
                                              DropdownSearchData(
                                            searchController:
                                            DoctorEditingController,
                                            searchInnerWidgetHeight: 50,
                                            searchInnerWidget: Container(
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                              child: TextFormField(
                                                expands: true,
                                                maxLines: null,
                                                controller:
                                                DoctorEditingController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  hintText:
                                                      'Search for an item...',
                                                  hintStyle: const TextStyle(
                                                      fontSize: 12),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              return item.value.toString().contains(searchValue);
                                            },
                                          ),
                                          onMenuStateChange: (isOpen) {
                                            if (!isOpen) {
                                              DoctorEditingController.clear();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(sh * 0.04),
                                Container(
                                  height: sh * 0.32,
                                  width: sw * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white?.withOpacity(0.4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.lightBlue.withOpacity(.4),
                                        blurRadius: 30,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.all(10),
                                        child: Text(
                                          'Description of the medical condition',
                                          style: GoogleFonts.labrada(
                                            fontSize: 20,
                                            color: AppTheme.dark,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.all(10),
                                        child: TextFormField(
                                          maxLines: 8,
                                          controller: textEditingController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 8,
                                            ),
                                            hintText: '...',
                                            hintStyle:
                                                const TextStyle(fontSize: 12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(sh * 0.02),
                                ElevatedButton(
                                  onPressed: () {

                                    int? id = int.tryParse(DoctorEditingController.text.split('_')[0]);
                                    print(id);
                                    dioService.CreateAppointments(
                                        context,
                                        widget.Data['id'].toString(),
                                        id.toString(),
                                        textEditingController.text.toString(),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero, backgroundColor: Colors.blue.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    shadowColor: Colors.lightBlue.withOpacity(0.4),
                                    elevation: 10,
                                  ),
                                  child: Container(
                                    height: sh * 0.06,
                                    width: sw * 0.5,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.labrada(
                                        fontSize: 20,
                                        color: AppTheme.white,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
