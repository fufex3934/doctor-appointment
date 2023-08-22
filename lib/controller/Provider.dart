import 'package:doctor/model/listCategory.dart';
import 'package:flutter/material.dart';

class PatientProvider extends ChangeNotifier {
  Patient? _patient;

  Patient? get patient => _patient;

  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  void setPatient(Patient patient) {
    _patient = patient;
    notifyListeners();
  }

  void setDoctor(Doctor doctor) {
    _doctor = doctor;
    notifyListeners();
  }
}
