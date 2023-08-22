import 'package:doctor/view/4Doctor/add_appointment.dart';
import 'package:doctor/view/chat_page.dart';
import 'package:flutter/material.dart';
import '../../assets/images/port/deviceIp.dart';
import '../../model/appointment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:doctor/controller/Provider.dart';
import './profile_doctor.dart';

class TodayAppointments extends StatefulWidget {
  static const routeName = 'today-appointment';

  const TodayAppointments({Key? key}) : super(key: key);

  @override
  State<TodayAppointments> createState() => _TodayAppointmentsState();
}

class _TodayAppointmentsState extends State<TodayAppointments> {
  final List<AppointmentData> appointments = [
    AppointmentData(
      doctorName: "Loki Bright",
      doctorImage: 'assets/images/doctor3.jpg',
      assistantName: "Kelly Williams",
      appointmentTime: "Today 10-30 am",
      backgroundColor: const Color(0xff93c5fd),
    ),
    AppointmentData(
      doctorName: "Loyri Brison",
      doctorImage: 'assets/images/doctor1.jpg',
      assistantName: "Katherine Moss",
      appointmentTime: "Today 11-30 am",
      backgroundColor: const Color(0xfffef9c3),
    ),
    AppointmentData(
      doctorName: "OrLando Digs",
      doctorImage: 'assets/images/doctor4.jpg',
      assistantName: "Kelly Williams",
      appointmentTime: "Today 12-30 am",
      backgroundColor: const Color(0xfffef9c3),
    ),
  ];
  List<dynamic> RequesterList = [];
  List<dynamic> requesterIds = [];
  List<Map<String, dynamic>> PatientList = [];
  late PatientProvider doctorProvider;
  int _selectedIndex = 0;

  // Define the pages corresponding to each tab
  final List<Widget> _pages = [
    DoctorProfile(),
    DoctorProfile(),
    DoctorProfile(),
    DoctorProfile(),
  ];

  @override
  void initState() {
    super.initState();
    doctorProvider = Provider.of<PatientProvider>(context, listen: false);
    getPatients();
  }

  Future<void> getPatients() async {
    final response = await http.get(
      Uri.parse(
          'http://${IpAddress()}:3000/users/Doctor/get-Patients/${doctorProvider.doctor!.loggedInUserData["_id"]}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(json.decode(response.body));

      if (data is List) {
        setState(() {
          RequesterList = data;
          print("data returned from backend $data");

          for (var doctorData in RequesterList) {
            // List<dynamic> requests = doctorData['RequesterId'] as List;
            // for (var request in requests) {
            //   print("Requesters =====>");
            //   print(request['requesterId']);

            //   if (request['requesterId'] != null) {
            //     requesterIds.add(request['requesterId']);
            //   }
            // }
            print("-----------------------------------");
            String ScheduledDate = "";
            String ScheduledTime = "";
            String ScheduledTimeDate = "";

            if (doctorData != null) {
              if (doctorData['Schedule'] != null) {
                print("schedule  ${doctorData["Schedule"]}");
                for (var patientSchedule in doctorData["Schedule"]) {
                  if (patientSchedule["doctorId"] ==
                      doctorProvider.doctor!.loggedInUserData["_id"]) {
                    DateTime scheduleDateTime =
                        DateTime.parse(patientSchedule["Time_Date"]);
                    DateTime currentDateTime = DateTime.now();

                    print(
                        "relative Schedule : ${patientSchedule["doctorId"]} ${patientSchedule["Time_Date"]}");
                    print("Scheduled Date Time :${scheduleDateTime} ");
                    if (scheduleDateTime.year == currentDateTime.year &&
                        scheduleDateTime.month == currentDateTime.month &&
                        scheduleDateTime.day == currentDateTime.day) {
                    } else {
                      Duration remainingDuration =
                          scheduleDateTime.difference(currentDateTime);

                      int remainingDays = remainingDuration.inDays;
                      int remainingMonths =
                          remainingDays ~/ 30; // Approximate months
                      int remainingYears =
                          remainingMonths ~/ 12; // Approximate years

                      print(
                          "$remainingYears years, $remainingMonths months, $remainingDays days");
                      String scheduledTime = "";

                      if (remainingYears != 0) {
                        scheduledTime += remainingYears != 0
                            ? "${remainingYears} year${remainingYears > 1 ? 's' : ''}"
                            : '';
                      }
                      if (remainingMonths != 0) {
                        if (scheduledTime.isNotEmpty) scheduledTime += ", ";
                        scheduledTime += remainingMonths != 0
                            ? "${remainingMonths} month${remainingMonths > 1 ? 's' : ''}"
                            : '';
                      }
                      if (remainingDays != 0) {
                        if (scheduledTime.isNotEmpty) scheduledTime += ", ";
                        scheduledTime += remainingDays != 0
                            ? "${remainingDays} day${remainingDays > 1 ? 's' : ''}"
                            : '';
                      }

                      // scheduledTime = scheduledTime + " Remaining";
                      ScheduledDate = scheduledTime;
                    }

                    Duration remainingDuration =
                        scheduleDateTime.difference(currentDateTime);
                    String remainingTime =
                        "${remainingDuration.inHours}:${remainingDuration.inMinutes.remainder(60)} Remaining";
                    ScheduledTime = "$remainingTime";
                    ScheduledTimeDate = "$ScheduledDate $ScheduledTime";

                    print("final Scheduled Time ${ScheduledTime}");
                    print("final Scheduled Date ${ScheduledDate}");
                  }
                }
              }

              PatientList.add({
                "id": doctorData['_id'],
                "email": doctorData['email'],
                "patientName": doctorData['fullName'],
                "doctorImage": 'assets/images/doctor1.jpg',
                "assistantName":
                    doctorProvider.doctor!.loggedInUserData["fullName"],
                "appointmentTime": ScheduledTimeDate,
                "backgroundColor": const Color(0xfffef9c3),
              });
              appointments.add(AppointmentData(
                doctorName: doctorData['fullName'],
                doctorImage: 'assets/images/doctor1.jpg',
                assistantName:
                    doctorProvider.doctor!.loggedInUserData["fullName"],
                appointmentTime: ScheduledTimeDate,
                backgroundColor: const Color(0xfffef9c3),
              ));
              print("Patient List ${PatientList}");
            } else {
              print("null");
            }
            print("-----------------------------------");
          }

          // Now you have the list of requesterIds
        });
      }
    }
    // print("Request lists : ");
    // print(RequesterList[0]["patient"]['fullName']);
    // print(RequesterList[0]["Overview"]);

    // print("----------------------------------");
  }

  // Function to handle tab navigation
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => _pages[_selectedIndex]));
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> showModal() async {
    //   print("=================================");

    //   await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text("Schedule Request"),
    //         content: Container(
    //             height: 300,
    //             //   child: SingleChildScrollView(
    //             //       scrollDirection: Axis.vertical,
    //             //       child: Column(children: dividedListDoctors)),

    //             child: FutureBuilder<void>(
    //               future: getRequests(), // Your data fetching function
    //               builder: (context, snapshot) {
    //                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                   return CircularProgressIndicator(); // Show a loading indicator
    //                 } else if (snapshot.hasError) {
    //                   return Text('Error: ${snapshot.error}');
    //                 } else {
    //                   // Data is available, render your widgets
    //                   return ListView.builder(
    //                     itemCount: RequesterList.length,
    //                     itemBuilder: (context, index) {
    //                       // final doctorData = RequesterList[index];
    //                       // final doctorName = doctorData['fullName'];

    //                       // return Column(
    //                       //   crossAxisAlignment: CrossAxisAlignment.start,
    //                       //   children: [
    //                       // Text("Doctor: $doctorName"),
    //                       // ListView.builder(
    //                       //   shrinkWrap: true,
    //                       //   physics: ClampingScrollPhysics(),
    //                       //   itemCount: RequesterList.length,
    //                       //   itemBuilder: (context, innerIndex) {
    //                       final request = RequesterList[index] != null
    //                           ? RequesterList[index]
    //                           : null;
    //                       final overview = request.Overview;

    //                       if (request != null) {
    //                         final patientName = request.RequesterId['fullName'];

    //                         return ListTile(
    //                           title: Text(patientName),
    //                           subtitle: Text(overview),
    //                         );
    //                       } else {
    //                         return ListTile(
    //                           title: Text("Patient: Not Available"),
    //                           subtitle: Text("Overview: Not Available"),
    //                         );
    //                       }
    //                       // },
    //                       // ),
    //                       // Divider();
    //                       // ],
    //                       // );
    //                     },
    //                   );
    //                 }
    //               },
    //             )),
    //         actions: [
    //           ElevatedButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.only(top: 30.0, left: 4, right: 4),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xfffefce8),
                      child: Icon(Icons.chevron_left),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Today's Appointment",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/doctor4.jpg'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              for (int i = 0; i < PatientList.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: PatientList[i]['backgroundColor'],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        PatientList[i]['doctorImage'],
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        PatientList[i]['patientName'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Doctors:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        PatientList[i]['assistantName'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.schedule,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  appointments[i].appointmentTime,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      color: Color(0xff081229),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                      senderEmail: doctorProvider
                                                              .doctor!
                                                              .loggedInUserData[
                                                          "email"],
                                                      senderId: doctorProvider
                                                              .doctor!
                                                              .loggedInUserData[
                                                          "_id"],
                                                      recieverEmail:
                                                          PatientList[i]
                                                              ['email'],
                                                      recieverId: PatientList[i]
                                                          ['id'],
                                                    )));
                                      },
                                      child: const RotatedBox(
                                        quarterTurns:
                                            1, // Rotate 90 degrees (quarter-turns 3)
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Center(
                                            child: Text(
                                              'Consult',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAppointments()));
                    },
                    child: Text("Add Appointment",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(30),
              //             ),
              //             color: Color(0xff081229),
              //           ),
              //           child: const Icon(Icons.date_range,
              //               color: Colors.white, size: 30),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(30),
              //             ),
              //             color: Color(0xffbfdbfe),
              //           ),
              //           child: const Icon(Icons.apps,
              //               color: Color(0xff081229), size: 30),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(30),
              //             ),
              //             color: Color(0xff081229),
              //           ),
              //           child: const Icon(Icons.brightness_7,
              //               color: Colors.white, size: 30),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue, // Set selected item color
        unselectedItemColor: Colors.blueGrey, // Set unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
