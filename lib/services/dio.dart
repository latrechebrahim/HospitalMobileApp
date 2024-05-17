import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hospital_managements/helper/Notif_error.dart';
import 'package:provider/provider.dart';

import '../Connection/connection.dart';
import '../patients/patients_personal_info.dart';
import 'auth.dart';

class DioService {
  final Dio _dio;

  // ignore: unused_field
  bool _isLoading = true;

  DioService() : _dio = Dio() {
    //for ios simulator
    _dio.options.baseUrl = 'http://127.0.0.1:8000/api';
    // for android emulator
    //10.50.0.61
    //192.168.137.1
    //
    // _dio.options.baseUrl = 'http://192.168.1.36/api/auth';
    //_dio.options.baseUrl = 'http://192.168.1.33/Backend/public/api';
    //  _dio.options.baseUrl = 'http://127.0.0.1:3306/api/auth';
    //_dio.options.baseUrl = 'http://10.0.2.2:8000/api';
    _dio.options.connectTimeout = Duration(seconds: 5);
    _dio.options.receiveTimeout = Duration(seconds: 3);
  }

  Future<Map<String, dynamic>> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      Response response = await _dio.get(
        '/login?email=' + email + '&password=' + password,
      );
      return response.data;
    } catch (e) {
      showDelayedAnimatedDialog(context as BuildContext, "Error",
          "An error occurred during login: $e", Duration(microseconds: 300));
      _isLoading = false;
      return Future.error(e);
    }
  }

  void register(
      BuildContext context,
      String firstname,
      String lastname,
      String phonenumber,
      String email,
      String password,
      String confirmpassword) async {
    try {
      _isLoading = true;
      var data = FormData.fromMap({
        'firstname': firstname,
        'lastname': lastname,
        'phonenumber': phonenumber,
        'email': email,
        'password': password,
        'confirmpassword': confirmpassword,
      });

      var response = await _dio.post(
        '/register',
        data: data,
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ConnectionLogin(),
          ),
        );
      }
    } catch (error) {
      _isLoading = false;
      DioError(requestOptions: RequestOptions(), error: error);
      showDelayedAnimatedDialog(
          context as BuildContext,
          "Error",
          "An error occurred during login: $error",
          Duration(microseconds: 300));
    } finally {
      _isLoading = false;
    }
  }

  void update(
    BuildContext context,
    int id,
    String firstname,
    String lastname,
    String phonenumber,
    String email,
    String date_birth,
  ) async {
    try {
      _isLoading = true;
      var data = FormData.fromMap({
        'firstname': firstname,
        'lastname': lastname,
        'phonenumber': phonenumber,
        'email': email,
        'date_birth': date_birth,
      });

      var response = await _dio.post(
        '/update/Patient?id=' + id.toString(),
        data: data,
      );
      if (response.statusCode == 200) {
        print(response.statusMessage);
      } else {
        print(response.statusMessage);
      }
    } catch (error) {
      print('An error occurred during login: $error');
      Duration(microseconds: 300);
    } finally {
      _isLoading = false;
    }
  }

  Future<Map<String, dynamic>> showInfo(
    String id,
  ) async {
    try {
      Response response = await _dio.get('/showAllDoctors/show/' + id);
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = true;
      print('Error occurred while fetching patient data: $e');
      return Future.error(
          'Failed to fetch patient data. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> showAppointments(
    String Id,
  ) async {
    _isLoading = true;
    try {
      Response response =
          await _dio.get('/showAppointments/' + Id + '/Patient');
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      print('Error occurred while fetching Appointments data: $e');
      return Future.error('Please check your internet connection.');
    }
  }

  Future<void> CreateAppointments(
    BuildContext context,
    String PatientId,
    String DoctorId,
    String content,
  ) async {
    try {
      _isLoading = true;
      var data = FormData.fromMap({
        'PatientId': PatientId,
        'DoctorId': DoctorId,
        'content': content,
        'confirmed': '0',
      });

      var response = await _dio.request(
        '/CreateAppointment/'+DoctorId+'/'+PatientId,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        showDelayedAnimatedDialog(context, "Successfullyr",
            "Create Appointment Successfully!", Duration(microseconds: 300));
      } else {
        print(response.statusMessage);
      }
    } catch (error) {
      showDelayedAnimatedDialog(
          context as BuildContext,
          "Error",
          "An error occurred during Create: $error",
          Duration(microseconds: 300));
    } finally {
      _isLoading = false;
    }
  }

  Future<Map<String, dynamic>> showDoctors() async {
    _isLoading = true;

    try {
      Response response = await _dio.get('/showDoctors');
      _isLoading = false;
      return response.data;
    } catch (e) {
      _isLoading = false;
      print('Error occurred while fetching Doctors data: $e');
      return Future.error('Please check your internet connection.');
    }
  }

  Future<List<String>> fetchSpecialtyFirstnames() async {
    _isLoading = true;

    try {
      Response response = await _dio.get('/showDoctorsB');
      _isLoading = false;
      final data = response.data['specialtyFirstnames'] as List<dynamic>;
      print(data.toString());
      return data.cast<String>().toList();
    } catch (e) {
      _isLoading = false;
      print('Error fetching data: $e');
      return [];
    }
  }
}
