import 'package:doctor/model/listCategory.dart';
import 'package:doctor/view/4Doctor/Register.dart';
import 'package:doctor/view/4Patient/patient_Registration.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String selectedOption = "Doctor";
  int currentPageIndex = 0;
  List<Widget> pages = [
    RegisterDoctor(),
    PatientRegistration(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = "Doctor";
                      currentPageIndex = 0;
                    });
                  },
                  child: Text(
                    "Doctor",
                    style: TextStyle(
                        fontSize: selectedOption == "Doctor" ? 25 : 20,
                        color: selectedOption == "Doctor"
                            ? Colors.blue
                            : Colors.black),
                  ),
                ),
                Container(
                  width: 2, // Width of the vertical line
                  height: 20, // Height of the vertical line
                  color: Colors.grey, // Color of the vertical line
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        selectedOption = "Patient";
                        currentPageIndex = 1;
                      });
                    },
                    child: Text(
                      "Patient",
                      style: TextStyle(
                          fontSize: selectedOption == "Patient" ? 25 : 20,
                          color: selectedOption == "Patient"
                              ? Colors.blue
                              : Colors.black),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: IndexedStack(
                index: currentPageIndex,
                children: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
