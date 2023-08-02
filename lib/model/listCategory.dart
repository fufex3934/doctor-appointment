import 'package:flutter/material.dart';

class Category {
  String name;
  Widget Image;

  Category({required this.name, required this.Image});
}

class DoctorsList {
  String name;
  String Speciality;
  Widget Image;
  double Rating;
  String bg;
  DoctorsList(
      {required this.name,
      required this.Speciality,
      required this.Image,
      required this.Rating,
      required this.bg});
}

class RatingStars {
  final double rating; // The rating value (from 0 to 5)
  final double size; // The size of each star icon
  final Color color; // The color of the filled star
  final Color borderColor; // The color of the star border

  RatingStars({
    required this.rating,
    this.size = 24.0,
    this.color = Colors.yellow,
    this.borderColor = Colors.grey,
  });
}

class IndividualDoctorsInformation {
  final String name;
  final String speciality;
  final String photo;
  final double Rating;

  IndividualDoctorsInformation(
      {required this.name,
      required this.speciality,
      required this.photo,
      required this.Rating}); //biography , number of patient and scheduale to be added
}
