import 'dart:convert';

import 'package:doctor/controller/Provider.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:doctor/controller/Provider.dart';
import '../../../assets/images/port/deviceIp.dart';
import '../../../controller/Provider.dart';

class BookAppointment extends StatefulWidget {
  String doctorId;
  BookAppointment({required this.doctorId, Key? key}) : super(key: key);
  // Get the current date as the default date

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

Widget buildCalendar(DateTime defaultDate) {
  // Your calendar data - You can replace this with actual data or use a package to get the dates.
  List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  List<List<int>> dates = [
    [26, 27, 28, 29, 30, 31, 1],
    [2, 3, 4, 5, 6, 7, 8],
    // Add more weeks here
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                // Handle previous month navigation
                print('Navigate to previous month');
              },
            ),
            Text(
              '${defaultDate.year}-${defaultDate.month}', // Replace with the current month and year.
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                // Handle next month navigation
                print('Navigate to next month');
              },
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(weekDays.length, (index) {
            return Text(weekDays[index]);
          }),
        ),
      ),
      SizedBox(height: 8),
      Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: dates.length * 7,
          itemBuilder: (context, index) {
            final weekIndex = index ~/ 7;
            final dayIndex = index % 7;
            final date = dates[weekIndex][dayIndex];
            return InkWell(
              onTap: () {
                // Handle date selection here
                print('Selected date: $date');
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: date == defaultDate.day
                      ? Colors.blue
                      : Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  date.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        date == defaultDate.day ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

List<String> time = [
  "09:00 Am",
  "09:30 Am",
  "10:00 Am",
  "10:30 Am",
  "11:00 Am",
  "11:30 Am",
];

class _BookAppointmentState extends State<BookAppointment> {
  DateTime today = DateTime.now();
  TextEditingController _overviewController = TextEditingController();
  late PatientProvider patientProvider;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    // setState(() {
    //   today = day;
    // });
  }
  @override
  void initState() {
    super.initState();
    patientProvider = Provider.of<PatientProvider>(context, listen: false);
  }

  Future<void> showModal(String title, String content) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // List<Widget> listFreeTimes = time.map((ele) {
  //   return OutlinedButton(onPressed: () {}, child: Text(ele));
  // }).toList();
  Widget buildGrid() {
    return GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        children: time.map((element) {
          return Container(
            width: 50, // Set your desired width here
            height: 50, // Set your desired height here
            child: OutlinedButton(
              onPressed: () {
                // Handle button tap here
                print(element);
              },
              child: Text(element),
            ),
          );
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    Future<void> Send_Request() async {
      print("patient Id :");
      print(patientProvider.patient?.loggedInUserData['_id']);
      print("doctor Id :");
      print(widget.doctorId);
      print(_overviewController.text);

      final response = await http.post(
          Uri.parse('http://${IpAddress()}:3000/users/Doctor/PatientRequest'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'overview': _overviewController.text,
            'requesterId': patientProvider.patient?.loggedInUserData['_id'],
            'doctorId': widget.doctorId
          }));

      if (response.statusCode == 200) {
        print('message delivered successfully');
      } else {
        print('Failed to register student');
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        title: Text(
          "Appointment",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _overviewController,
                maxLines:
                    null, // This allows the text field to have multiple lines
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Enter your text...',
                    border: OutlineInputBorder(),
                    label: Text("Write Overview On Your Request Issue")),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white12,
              //       borderRadius: BorderRadius.circular(20),
              //       border: Border.all(color: Colors.black)),
              //   child: TableCalendar(
              //     locale: "en_US",
              //     rowHeight: 43,
              //     headerStyle: HeaderStyle(
              //         formatButtonVisible: false, titleCentered: true),
              //     availableGestures: AvailableGestures.all,
              //     selectedDayPredicate: (day) => isSameDay(day, today),
              //     onDaySelected: _onDaySelected,
              //     focusedDay: today,
              //     firstDay: DateTime.utc(today.year, today.month, today.day),
              //     lastDay: DateTime.utc(2030, 8, 14),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   "Time",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20,
              //       color: Colors.black),
              // ),
              SizedBox(
                height: 10,
              ),
              // Expanded(child: buildGrid()),
              Container(
                width: double.infinity,
                height: 49,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 17),
                child: ElevatedButton(
                  onPressed: Send_Request,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Make an Appointment"),
                      Icon(Icons.keyboard_double_arrow_right)
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0e0985),
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
