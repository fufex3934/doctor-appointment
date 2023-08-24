import 'package:doctor/model/listCategory.dart';
import 'package:flutter/material.dart';

class PatientProvider extends ChangeNotifier {
  Patient? _patient;

  Patient? get patient => _patient;

  void setPatient(Patient patient) {
    _patient = patient;
    notifyListeners();
  }

  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  void setDoctor(Doctor doctor) {
    _doctor = doctor;
    notifyListeners();
  }
}
