import 'package:flutter/material.dart';

class AppointmentData {
  final String doctorName;
  final String doctorImage;
  final String assistantName;
  final String appointmentTime;
  final Color backgroundColor;

  AppointmentData({
    required this.doctorName,
    required this.doctorImage,
    required this.assistantName,
    required this.appointmentTime,
    required this.backgroundColor,
  });
}
