import 'package:doctor/model/listCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientProvider extends ChangeNotifier {
  Patient? _patient;

  Patient? get patient => _patient;

  void setPatient(Patient patient) {
    _patient = patient;
    notifyListeners();
  }
}
