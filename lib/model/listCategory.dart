import 'package:flutter/material.dart';

class Category {
  String name;
  Widget icon;

  Category({required this.name, required this.icon});
}

class DoctorsList {
  String name;
  String Speciality;
  Widget Image;
  double Rating;
  DoctorsList(
      {required this.name,
      required this.Speciality,
      required this.Image,
      required this.Rating});
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
    this.borderColor = Colors.black,
  });
}
